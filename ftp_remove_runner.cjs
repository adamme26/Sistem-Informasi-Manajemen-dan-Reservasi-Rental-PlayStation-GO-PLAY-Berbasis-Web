const ftp = require("basic-ftp");
async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Removing artisan_runner from public...");
        await client.remove("public_html/public/artisan_runner.php");
        console.log("Delete complete.");
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
