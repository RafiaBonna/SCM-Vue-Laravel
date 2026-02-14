<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DepoSaleDetail extends Model
{
    use HasFactory;

    // ডাটাবেস টেবিলের নাম যদি 'depo_sale_details' হয় (প্লুরাল), 
    // তবে লারাভেল অটো চিনে নেয়। তাও নিশ্চিত করার জন্য এটি দেওয়া ভালো:
    protected $table = 'depo_sale_details';

    protected $fillable = [
        'depo_sale_id', 
        'product_id', 
        'quantity', 
        'unit_price', 
        'subtotal'
    ];

    /**
     * এই ডিটেইলটি কোন মেইন ইনভয়েসের আন্ডারে তা পাওয়ার জন্য
     */
    public function sale()
    {
        return $this->belongsTo(DepoSale::class, 'depo_sale_id');
    }

    /**
     * এই লাইনে কোন প্রোডাক্টটি বিক্রি হয়েছে তা জানার জন্য
     */
    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }
}