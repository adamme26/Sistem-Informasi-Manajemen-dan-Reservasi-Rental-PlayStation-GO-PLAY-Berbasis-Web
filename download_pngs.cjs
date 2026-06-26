const https = require('https');
const fs = require('fs');

const download = (url, dest) => {
  return new Promise((resolve, reject) => {
    const file = fs.createWriteStream(dest);
    https.get(url, { headers: { 'User-Agent': 'Node.js' } }, (response) => {
      if (response.statusCode === 301 || response.statusCode === 302) {
          return download(response.headers.location, dest).then(resolve).catch(reject);
      }
      response.pipe(file);
      file.on('finish', () => file.close(resolve));
    }).on('error', (err) => {
      fs.unlink(dest, () => {});
      reject(err);
    });
  });
};

async function main() {
  try {
    // A known raw github URL for transparent PS4/PS5?
    // Let's use Wikipedia images again, but this time with a normal User-Agent
    await download('https://upload.wikimedia.org/wikipedia/commons/8/8c/PlayStation_4_Console_and_Controller.png', 'public/images/ps4.png');
    await download('https://upload.wikimedia.org/wikipedia/commons/1/1b/PlayStation_5_and_DualSense_with_transparent_background.png', 'public/images/ps5.png');
    console.log("Downloaded successfully.");
  } catch(e) {
    console.log(e);
  }
}
main();
