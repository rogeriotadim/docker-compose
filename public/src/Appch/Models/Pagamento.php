<?php
namespace Appch\Models;

Class Pagamento extends \Illuminate\Database\Eloquent\Model
{
    /**
     * Get the brand that the product belongs to.
     */
    public function user()
    {
        return $this->belongsTo('Appch\Models\User','id_usuario');
    }
}

?>


