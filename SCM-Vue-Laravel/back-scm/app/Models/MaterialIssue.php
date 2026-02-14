<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MaterialIssue extends Model
{
    use HasFactory;

    protected $fillable = ['issue_number', 'issue_date', 'note'];

    public function items()
    {
        return $this->hasMany(MaterialIssueItem::class);
    }
}