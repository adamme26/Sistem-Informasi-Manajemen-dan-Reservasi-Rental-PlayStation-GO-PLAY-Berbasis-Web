const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Uploading SocialLoginController.php...");
        await client.uploadFrom("app/Http/Controllers/Auth/SocialLoginController.php", "goplay_backend/app/Http/Controllers/Auth/SocialLoginController.php");
        console.log("Upload successful!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
