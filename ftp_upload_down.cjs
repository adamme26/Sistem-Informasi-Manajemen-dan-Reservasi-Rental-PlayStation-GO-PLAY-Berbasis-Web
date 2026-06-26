const ftp = require("basic-ftp");
async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        await client.uploadFrom("storage/framework/down", "public_html/storage/framework/down");
        console.log("Uploaded storage/framework/down to enable maintenance mode");
    } catch(err) {
        console.log(err);
    }
    client.close();
}
main();
