const ftp = require("basic-ftp");
async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        await client.uploadFrom("routes/web.php", "public_html/routes/web.php");
        console.log("Uploaded updated routes/web.php");
    } catch(err) {
        console.log(err);
    }
    client.close();
}
main();
