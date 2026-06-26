const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Uploading app.css...");
        await client.uploadFrom("public/css/app.css", "public_html/my-project/css/app.css");
        
        console.log("Uploading app.blade.php...");
        await client.uploadFrom("resources/views/layouts/app.blade.php", "goplay_backend/resources/views/layouts/app.blade.php");
        
        console.log("Upload successful!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
