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
        
        console.log("Listing goplay_backend/public...");
        const publicFiles = await client.list("goplay_backend/public");
        
        for (const item of publicFiles) {
            console.log(`Moving ${item.name}...`);
            await client.rename(`goplay_backend/public/${item.name}`, `public_html/my-project/${item.name}`);
        }
        
        console.log("Updating index.php in my-project...");
        await client.downloadTo("index_tmp.php", "public_html/my-project/index.php");
        
        let indexContent = fs.readFileSync("index_tmp.php", "utf8");
        // Replace paths to point to goplay_backend
        // e.g. require __DIR__.'/../vendor/autoload.php'; -> require __DIR__.'/../../goplay_backend/vendor/autoload.php';
        indexContent = indexContent.replace(/__DIR__\.'\/\.\.\/vendor/g, "__DIR__.'/../../goplay_backend/vendor");
        indexContent = indexContent.replace(/__DIR__\.'\/\.\.\/bootstrap/g, "__DIR__.'/../../goplay_backend/bootstrap");
        
        fs.writeFileSync("index_tmp.php", indexContent);
        
        await client.uploadFrom("index_tmp.php", "public_html/my-project/index.php");
        console.log("Done updating index.php!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
