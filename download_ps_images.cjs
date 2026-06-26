const fs = require('fs');
const https = require('https');

function download(hostname, path, dest) {
  return new Promise((resolve, reject) => {
    const file = fs.createWriteStream(dest);
    const options = {
      hostname: hostname,
      path: path,
      headers: { 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36' }
    };
    https.get(options, function(response) {
      if (response.statusCode === 301 || response.statusCode === 302) {
          const url = new URL(response.headers.location);
          return download(url.hostname, url.pathname + url.search, dest).then(resolve).catch(reject);
      }
      response.pipe(file);
      file.on('finish', function() {
        file.close(() => resolve(dest));
      });
    }).on('error', function(err) {
      fs.unlink(dest, () => {});
      reject(err.message);
    });
  });
}

async function main() {
  try {
    console.log("Downloading PS4...");
    await download('upload.wikimedia.org', '/wikipedia/commons/8/8c/PlayStation_4_Console_and_Controller.png', 'public/images/ps4.png');
    console.log("Downloading PS5...");
    await download('upload.wikimedia.org', '/wikipedia/commons/1/1b/PlayStation_5_and_DualSense_with_transparent_background.png', 'public/images/ps5.png');
    console.log("Done downloading transparent images.");
  } catch (err) {
    console.error(err);
  }
}

main();
