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
        
        await client.cd("public_html");
        await client.remove("default.html").catch(()=>console.log("no default.html"));
        await client.remove("default-welcome.html").catch(()=>console.log("no default-welcome"));
        console.log("Deleted default HTMLs");
    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
