const ftp = require("basic-ftp");
const fs = require("fs");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Uploading portfolio index.html...");
        await client.uploadFrom("index.html", "public_html/index.html");
        
        console.log("Uploading blank .htaccess to reset root routing...");
        fs.writeFileSync("blank.htaccess", "Options -Indexes\n");
        await client.uploadFrom("blank.htaccess", "public_html/.htaccess");
        
        console.log("Done uploading portfolio!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
