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
        
        await client.cd("/public_html/public/images");
        await client.uploadFrom("public/images/ps4.png", "ps4.png");
        console.log("Uploaded original ps4.png");
        
        await client.uploadFrom("public/images/ps5.png", "ps5.png");
        console.log("Uploaded original ps5.png");

    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
