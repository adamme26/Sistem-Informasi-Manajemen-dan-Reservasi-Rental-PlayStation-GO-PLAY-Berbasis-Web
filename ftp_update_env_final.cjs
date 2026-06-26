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
        
        console.log("Downloading .env from goplay_backend...");
        await client.downloadTo("live_env_final.txt", "goplay_backend/.env");
        
        let envContent = fs.readFileSync("live_env_final.txt", "utf8");
        
        // Replace APP_URL
        envContent = envContent.replace(/APP_URL=http:\/\/localhost:8000/g, "APP_URL=https://portofolio-noval.my.id/my-project");
        // Also if it was already changed to portofolio-noval.my.id
        envContent = envContent.replace(/APP_URL=https:\/\/portofolio-noval\.my\.id(\r?\n)/, "APP_URL=https://portofolio-noval.my.id/my-project$1");
        
        // Update OAuth redirect URIs
        envContent = envContent.replace(/https:\/\/portofolio-noval\.my\.id\/auth/g, "https://portofolio-noval.my.id/my-project/auth");
        
        fs.writeFileSync("live_env_final.txt", envContent);
        console.log("Uploading modified .env...");
        
        await client.uploadFrom("live_env_final.txt", "goplay_backend/.env");
        console.log("Done!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
