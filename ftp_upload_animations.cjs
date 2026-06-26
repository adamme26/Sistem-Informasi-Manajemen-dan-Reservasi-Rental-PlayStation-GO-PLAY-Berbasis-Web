const ftp = require("basic-ftp");
async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        await client.uploadFrom("resources/views/layouts/app.blade.php", "public_html/resources/views/layouts/app.blade.php");
        await client.uploadFrom("resources/views/welcome.blade.php", "public_html/resources/views/welcome.blade.php");
        console.log("Uploaded updated app.blade.php and welcome.blade.php with animations");
    } catch(err) {
        console.log(err);
    }
    client.close();
}
main();
