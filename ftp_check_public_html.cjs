const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Listing public_html:");
        const list = await client.list("public_html");
        for (const item of list) {
            console.log(item.name);
        }
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
