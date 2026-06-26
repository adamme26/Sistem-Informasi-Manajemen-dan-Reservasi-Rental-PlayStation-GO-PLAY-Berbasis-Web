const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Uploading welcome.blade.php...");
        await client.uploadFrom("resources/views/welcome.blade.php", "goplay_backend/resources/views/welcome.blade.php");
        
        console.log("Uploading create.blade.php...");
        await client.uploadFrom("resources/views/bookings/create.blade.php", "goplay_backend/resources/views/bookings/create.blade.php");
        
        console.log("Upload successful!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
