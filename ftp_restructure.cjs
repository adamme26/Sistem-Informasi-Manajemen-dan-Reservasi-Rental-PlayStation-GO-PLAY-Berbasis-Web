const ftp = require("basic-ftp");

async function main() {
    const client = new ftp.Client();
    try {
        await client.access({
            host: "202.155.137.33",
            user: "portof23",
            password: "6M]Y*C0n1knd7F",
        });
        
        console.log("Creating goplay_backend directory...");
        await client.ensureDir("goplay_backend");
        
        // Go back to root
        await client.cd("/");
        
        const filesToMove = [
            ".editorconfig", ".env", ".env.example", ".gitattributes", ".gitignore",
            ".phpunit.result.cache", "artisan", "composer.json", "composer.lock",
            "package.json", "package-lock.json", "phpunit.xml", "postcss.config.js",
            "README.md", "tailwind.config.js", "test_output.txt", "vite.config.js",
            "zip_project.cjs", "app", "bootstrap", "config", "database", "public",
            "resources", "routes", "storage", "tests", "vendor", "artisan_runner.php",
            ".composer", "composer_runner.php", "live_env.txt", "live_env2.txt", "live_env3.txt"
        ];
        
        for (const file of filesToMove) {
            console.log(`Moving ${file}...`);
            try {
                await client.rename(`public_html/${file}`, `goplay_backend/${file}`);
            } catch (e) {
                console.log(`Failed to move ${file} (might not exist)`);
            }
        }
        
        // Move .htaccess explicitly
        console.log("Moving .htaccess...");
        try {
            await client.rename("public_html/.htaccess", "goplay_backend/.htaccess_old");
        } catch (e) {
            console.log("No .htaccess found");
        }
        
        // Now set up the new my-project structure
        console.log("Creating my-project directory...");
        await client.ensureDir("public_html/my-project");
        
        // Move contents of public to my-project
        console.log("Listing goplay_backend/public...");
        const publicFiles = await client.list("goplay_backend/public");
        
        for (const item of publicFiles) {
            console.log(`Moving public/${item.name}...`);
            await client.rename(`goplay_backend/public/${item.name}`, `public_html/my-project/${item.name}`);
        }
        
        console.log("Server restructure complete!");
        
    } catch(err) {
        console.log("FTP Error: ", err.message);
    }
    client.close();
}
main();
