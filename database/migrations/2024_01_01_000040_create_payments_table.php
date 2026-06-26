<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('booking_id')->constrained()->onDelete('cascade');
            $table->decimal('amount', 10, 2);
            $table->string('bank_name')->default('Bank BCA');
            $table->string('account_number')->default('1234567890');
            $table->string('account_name')->default('GOPLAY Game Rental');
            $table->string('transfer_proof')->nullable();
            $table->enum('status', ['unpaid', 'uploaded', 'verified'])->default('unpaid');
            $table->timestamp('verified_at')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
