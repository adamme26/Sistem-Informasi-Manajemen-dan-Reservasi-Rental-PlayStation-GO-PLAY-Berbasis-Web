const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
            secure: false
        });
        
        await client.cd("public_html/resources/views/layouts");
        await client.uploadFrom("resources/views/layouts/app.blade.php", "app.blade.php");
        console.log("Uploaded updated app.blade.php");

    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
