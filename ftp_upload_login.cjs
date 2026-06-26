const ftp = require("basic-ftp");
async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        await client.uploadFrom("resources/views/auth/login.blade.php", "public_html/resources/views/auth/login.blade.php");
        console.log("Uploaded updated login.blade.php");
    } catch(err) {
        console.log(err);
    }
    client.close();
}
main();
