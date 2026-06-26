const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Uploading index.html...");
        await client.uploadFrom("index.html", "public_html/index.html");
        
        console.log("Uploading projects.html...");
        await client.uploadFrom("projects.html", "public_html/projects.html");
        
        console.log("Done updating both files on live server!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
