<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductSale extends Model
{
    use HasFactory;

    // ডাটাবেসে যে কলামগুলো সেভ করার অনুমতি থাকবে
    protected $fillable = [
        'invoice_no',
        'sale_date',
        'depo_id',
        'total_amount',
        'status', // pending, accepted, rejected
        'note',
        'reject_note'
    ];

    /**
     * একটি চালানের অনেকগুলো আইটেম থাকতে পারে (One-to-Many)
     */
    public function details()
    {
        return $this->hasMany(ProductSaleDetail::class, 'product_sale_id');
    }

    /**
     * চালানটি কোন ডেপোর জন্য তৈরি করা হয়েছে
     */
    public function depo()
    {
        return $this->belongsTo(Depo::class, 'depo_id');
    }
}