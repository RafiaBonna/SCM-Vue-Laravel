<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RawMaterialStock extends Model
{
    use HasFactory;

    /**
     * যে টেবিলটির সাথে এই মডেলটি যুক্ত।
     */
    protected $table = 'raw_material_stocks';

    /**
     * যে কলামগুলো মাস-অ্যাসাইনমেন্টের (Mass Assignment) জন্য উন্মুক্ত।
     */
    protected $fillable = [
        'raw_material_id',
        'quantity',
        'type',         // 'in' অথবা 'out'
        'reference_id', // পারচেজ আইডি বা সেলস আইডি
        'note'
    ];

    /**
     * সম্পর্ক: প্রতিটি স্টক এন্ট্রি একটি নির্দিষ্ট র মেটেরিয়ালের সাথে যুক্ত।
     */
    public function raw_material()
    {
        return $this->belongsTo(RawMaterial::class);
    }
}