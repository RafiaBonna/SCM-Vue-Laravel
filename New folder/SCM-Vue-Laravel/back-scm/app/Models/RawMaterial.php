<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class RawMaterial extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'unit_id',
        'alert_stock',
        'description',
    ];

    public function unit()
    {
        return $this->belongsTo(Unit::class);
    }
}