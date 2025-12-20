<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductWastage extends Model
{
    use HasFactory;

    protected $fillable = ['wastage_number', 'date', 'product_id', 'quantity', 'remarks'];

    public function product() {
        return $this->belongsTo(Product::class);
    }
}