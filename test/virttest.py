#!/usr/bin/env python
'''
Usage: virttest.py VDOMAIN VUSER VUSER_IDRSA VHOST_RSA

  VDOMAIN     - the virtual domain to run the tests on
  VUSER       - the existing user in the virtual domain
  VUSER_IDRSA - the id_rsa file to identify as VUSER
  VHOST_RSA   - the rsa key for the host

  the values will be used to: ssh VUSER@VDOMAIN_IP cmd
  where the user known by the VUSER_IDRSA and does not prompt for password.

  The test connects to the vdoman, clone's the sources the runs the make
  test an install targerts the veryfiys the evironment after the install
'''

import sys
import os
import re
import subprocess
import socket

import paramiko as ssh
import base64

vdomain = sys.argv[1]
vuser = sys.argv[2]
vidrsa = sys.argv[3]
vhostkey = sys.argv[4]

testemail = 'tester@nowhere.local'

glorigin = subprocess.check_output(['git',
                                    'config',
                                    '--get',
                                    'remote.origin.url']
                                  ).decode('utf-8').strip()

print("Args:",', '.join([vdomain,vuser,vidrsa]))

# actually, pull this whole thing apart and put it back together.
# WONDER if fqdn would work....
# glorigin_host = re.sub(r'.*git@([^:]+):.*',r'\1',glorigin)
glo_match = re.search(r'\s*(git)@([^:]+):(.*)$',glorigin)
glorigin_user = glo_match.group(1)
glorigin_host = glo_match.group(2)
glorigin_repo = glo_match.group(3)
if (not glorigin_user or
        not glorigin_host or
        not glorigin_repo):
   raise Exception('Failed to parse gitolite origin:',glorigin)

# short term fix for short term problem, will fix when test fails
if '.local' in glorigin_host:
    fqdn = socket.getfqdn()
    dn = re.sub(r'^[^\.]+\.(.+)',r'\1',fqdn)
    glorigin_host = glorigin_host.replace('local',dn)
    print( 'dnfix:',glorigin_host )

glorigin = ''.join([glorigin_user,
                    '@',
                    glorigin_host,
                    ':',
                    glorigin_repo,
                    ])

glorigin_ip = socket.gethostbyname(glorigin_host)
print 'GL',glorigin
glorigin = glorigin.replace(glorigin_host,glorigin_ip)
print 'GL host:',glorigin_host,'ip:',glorigin_ip,'gl:',glorigin

hostip = socket.gethostbyname(socket.getfqdn())

print('host ip:',hostip)

# get the domain's ip
dom_ifout = subprocess.check_output(['virsh',
                                     'domiflist',
                                     vdomain]).decode('utf-8')

dom_mac = re.search(r'rtl8139\s+([0-9a-fA-F:]+)',dom_ifout).group(1)
if not dom_mac:
    print('Error could not find mac addr in ',dom_ifout)

print('Mac:',dom_mac)
arp_out = subprocess.check_output(['arp','-an']).decode('utf-8')

dom_ip_pat = r'.*\(([\d\.]+)\).*'+dom_mac

print('pat:',dom_ip_pat)
print('arp:',arp_out)

dom_ip = re.search( dom_ip_pat, arp_out ).group(1)
print('IP:',dom_ip)

host_key_data = ''
with open(vhostkey,'r') as f:
    host_key_data = f.read()

host_key_data = host_key_data.replace('ssh-rsa ','')

print 'hk',repr(host_key_data)

host_key = ssh.RSAKey(data=base64.decodestring(host_key_data))

client = ssh.SSHClient()
client.get_host_keys().add(dom_ip,'ssh-rsa', host_key)
client.connect(dom_ip, username=vuser,key_filename=vidrsa)


sftp = client.open_sftp()
vtinfofn='{vh}.testhost.info'.format(vh=vdomain)
testscript = '''#!/bin/bash
set -x

tinfofn={ftinfofn}
echo > $tinfofn
for uarg in -s -n -r -v -m -p -i -o; do
  echo uname $uarg: `uname $uarg` >> tinfofn
done
[ -d $HOME/products ] || mkdir $HOME/products
cd $HOME/products
git clone {fglorigin}
cd {frepo}
git checkout test
./configure --with-email={ftestemail}
make check > make.check.out 2>&1
make install
'''.format( ftinfofn=vtinfofn,
            fglorigin=glorigin,
            frepo=glorigin_repo,
            ftestemail=testemail )

vtest_script_fn = './testproduct.bash'
print 'Testscript:',testscript
with sftp.open( vtest_script_fn,'w') as f:
  f.write(testscript)

sftp.chmod( vtest_script_fn, 0775 )
vin, vout, verr = client.exec_command(vtest_script_fn)

vout_content = vout.read()
verr_content = verr.read()

if verr_content:
    print 'FAIL:',verr_content
    sys.exit(2)
    
vtinfo = ''
with sftp.open( vtinfofn, 'r' ) as f:
    vtinfo = f.read()
    
sftp.close()

# Yes I want to close the client to get the reconnection
client.close()

if '.Xdefaults' not in vout_content:
    print('Error missing .Xdefaults from output:',vout_content)
    sys.exit(1)
else:
    client.connect(dom_ip, username=vuser,key_filename=vidrsa)
    vin, vout, verr = client.exec_command('env')
    vout_content = vout.read()
    vin, vout, verr = client.exec_command('alias')
    vout_content += vout.read()
    vin, vout, verr = client.exec_command('declare -f')
    vout_content += vout.read()
    print('Feature: locale environment config\n'+
          ' Scenario: user environment is configured on login\n')
    if 'OSNAME' in vout_content and testemail in vout_content:
        print(' Given: LoginUtils has been installed\n'+
              ' When: the user logs in\n'+
              ' Then: the custom environment is set\n\n'+
              'Feature: Environment provides:\n'+vout_content)
    else:
        print(' FAIL! to set OSNAME or REPLYTO')
        sys.exit(1)

sys.exit(0)
