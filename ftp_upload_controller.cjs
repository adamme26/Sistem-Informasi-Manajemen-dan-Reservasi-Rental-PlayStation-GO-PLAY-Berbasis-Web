const ftp = require("basic-ftp");
async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        await client.uploadFrom("app/Http/Controllers/Admin/Auth/AuthenticatedSessionController.php", "public_html/app/Http/Controllers/Admin/Auth/AuthenticatedSessionController.php");
        console.log("Uploaded updated Admin/Auth/AuthenticatedSessionController.php");
    } catch(err) {
        console.log(err);
    }
    client.close();
}
main();
