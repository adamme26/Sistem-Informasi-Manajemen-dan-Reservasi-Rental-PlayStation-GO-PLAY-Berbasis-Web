const Client = require('ssh2-sftp-client');
const { Client: SSHClient } = require('ssh2');
const fs = require('fs');
const path = require('path');

const passwordsToTry = [
  '6MlY*C0n1knd7F', // lowercase L
  '6MIY*C0n1knd7F', // uppercase I
  '6M|Y*C0n1knd7F', // pipe
  '6M1Y*C0n1knd7F'  // number one
];

const configBase = {
  host: '202.155.137.33',
  port: 64000,
  username: 'portof23'
};

const localFile = path.join(__dirname, 'goplay-siap-upload.zip');
const remoteFile = '/home/portof23/public_html/goplay-siap-upload.zip';

async function main() {
  for (let pwd of passwordsToTry) {
    console.log('Trying password:', pwd);
    const config = { ...configBase, password: pwd };
    const sftp = new Client();
    try {
      await sftp.connect(config);
      console.log('SUCCESS with password:', pwd);
      
      console.log('Uploading zip file...');
      await sftp.fastPut(localFile, remoteFile);
      console.log('Upload complete.');
      await sftp.end();

      console.log('Connecting SSH...');
      const conn = new SSHClient();
      conn.on('ready', () => {
        console.log('SSH Client :: ready');
        
        const commands = [
          'cd /home/portof23/public_html',
          'unzip -o goplay-siap-upload.zip',
          'rm -f index.php default.php goplay-siap-upload.zip goplay-siap-upload.zip.zip',
          'echo "<IfModule mod_rewrite.c>" > .htaccess',
          'echo "    RewriteEngine On" >> .htaccess',
          'echo "    RewriteRule ^(.*)$ public/\\$1 [L]" >> .htaccess',
          'echo "</IfModule>" >> .htaccess'
        ].join(' && ');

        conn.exec(commands, (err, stream) => {
          if (err) throw err;
          stream.on('close', (code, signal) => {
            console.log('Stream :: close :: code: ' + code + ', signal: ' + signal);
            conn.end();
          }).on('data', (data) => {
            console.log('STDOUT: ' + data);
          }).stderr.on('data', (data) => {
            console.log('STDERR: ' + data);
          });
        });
      }).connect(config);
      
      // Stop trying other passwords
      return;
    } catch (err) {
      console.log('Failed:', err.message);
    }
  }
}

main();
