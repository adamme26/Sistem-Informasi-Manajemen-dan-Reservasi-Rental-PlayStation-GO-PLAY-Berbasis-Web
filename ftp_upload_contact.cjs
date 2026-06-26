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
        
        console.log("Uploading send_mail.php...");
        await client.uploadFrom("send_mail.php", "public_html/send_mail.php");
        
        console.log("Done updating both files on live server!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
