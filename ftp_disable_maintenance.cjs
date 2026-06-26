const ftp = require("basic-ftp");
async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        await client.remove("public_html/storage/framework/down");
        console.log("Maintenance mode disabled (down file removed)");
    } catch(err) {
        console.log("Error or file already removed: ", err.message);
    }
    client.close();
}
main();
