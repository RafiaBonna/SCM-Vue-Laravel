<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DepoSale extends Model
{
    use HasFactory;

    protected $fillable = [
        'invoice_no', 
        'sale_date', 
        'depo_id', 
        'sale_type',   // 'distributor' অথবা 'customer'
        'sale_to_id',  // ডিস্ট্রিবিউটর বা কাস্টমার আইডি
        'total_amount', 
        'status',      // pending, accepted, rejected
        'note', 
        'reject_note'
    ];

    /**
     * ইনভয়েসের প্রোডাক্ট লিস্ট পাওয়ার জন্য
     */
    public function details()
    {
        return $this->hasMany(DepoSaleDetail::class, 'depo_sale_id');
    }

    /**
     * কোন ড্যাপো থেকে বিক্রি হয়েছে
     */
    public function depo()
    {
        return $this->belongsTo(Depo::class, 'depo_id');
    }

    /**
     * সেলটি কার কাছে হয়েছে তা ডাইনামিকভাবে পাওয়ার জন্য
     */
    public function receiver()
    {
        if ($this->sale_type === 'distributor') {
            return $this->belongsTo(Distributor::class, 'sale_to_id');
        }
        return $this->belongsTo(Customer::class, 'sale_to_id');
    }
}