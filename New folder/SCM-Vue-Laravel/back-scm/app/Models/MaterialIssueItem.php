<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MaterialIssueItem extends Model
{
    protected $fillable = ['material_issue_id', 'raw_material_id', 'quantity', 'batch_no'];

    public function raw_material()
    {
        return $this->belongsTo(RawMaterial::class);
    }
}