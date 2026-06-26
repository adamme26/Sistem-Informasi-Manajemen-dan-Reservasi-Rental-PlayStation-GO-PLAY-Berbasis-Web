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
        
        await client.cd("/goplay_backend/app/Models");
        await client.uploadFrom("app/Models/Booking.php", "Booking.php");
        console.log("Uploaded Booking.php");

        await client.cd("/goplay_backend/app/Http/Controllers");
        await client.uploadFrom("app/Http/Controllers/BookingController.php", "BookingController.php");
        console.log("Uploaded BookingController.php");

        await client.cd("/goplay_backend/app/Http/Controllers/Admin");
        await client.uploadFrom("app/Http/Controllers/Admin/BookingAdminController.php", "BookingAdminController.php");
        console.log("Uploaded BookingAdminController.php");

        await client.cd("/goplay_backend/routes");
        await client.uploadFrom("routes/web.php", "web.php");
        console.log("Uploaded web.php");

        await client.cd("/goplay_backend/resources/views");
        await client.uploadFrom("resources/views/dashboard.blade.php", "dashboard.blade.php");
        console.log("Uploaded dashboard.blade.php");

        await client.cd("/goplay_backend/resources/views/admin");
        await client.uploadFrom("resources/views/admin/dashboard.blade.php", "dashboard.blade.php");
        console.log("Uploaded admin/dashboard.blade.php");

        await client.cd("/goplay_backend/resources/views/admin/bookings");
        await client.uploadFrom("resources/views/admin/bookings/index.blade.php", "index.blade.php");
        console.log("Uploaded admin/bookings/index.blade.php");

        await client.cd("/goplay_backend/resources/views/bookings");
        await client.uploadFrom("resources/views/bookings/show.blade.php", "show.blade.php");
        console.log("Uploaded bookings/show.blade.php");

        console.log("Realtime changes uploaded successfully!");
    } catch (err) {
        console.log("FTP Error:", err);
    }
    client.close();
}

main();
