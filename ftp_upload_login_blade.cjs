const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Uploading login.blade.php...");
        await client.uploadFrom("resources/views/auth/login.blade.php", "goplay_backend/resources/views/auth/login.blade.php");
        console.log("Upload successful!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
