<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = htmlspecialchars($_POST['name']);
    $email = htmlspecialchars($_POST['email']);
    $phone = htmlspecialchars($_POST['phone']);
    $message = htmlspecialchars($_POST['message']);

    $to = "muhamadnoval649@gmail.com";
    $subject = "Pesan Baru dari Portofolio: $name";
    
    $body = "Anda menerima pesan baru dari form kontak portofolio Anda.\n\n";
    $body .= "Nama: $name\n";
    $body .= "Email: $email\n";
    $body .= "Nomor Ponsel: $phone\n\n";
    $body .= "Pesan:\n$message\n";

    // Header untuk email
    $headers = "From: noreply@portofolio-noval.my.id\r\n";
    $headers .= "Reply-To: $email\r\n";

    // Kirim email
    if (mail($to, $subject, $body, $headers)) {
        echo "<script>
                alert('Pesan berhasil dikirim!');
                window.location.href = 'index.html';
              </script>";
    } else {
        echo "<script>
                alert('Maaf, pesan gagal dikirim. Silakan coba kontak langsung via Email/Instagram.');
                window.location.href = 'index.html';
              </script>";
    }
} else {
    header("Location: index.html");
}
?>
