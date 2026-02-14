<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductReceiveReturn extends Model
{
    use HasFactory;

    protected $fillable = ['return_number', 'return_date', 'product_id', 'quantity', 'reason'];

    public function product() {
        return $this->belongsTo(Product::class);
    }
}