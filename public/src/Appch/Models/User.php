<?php

namespace Appch\Models;

class User extends \Illuminate\Database\Eloquent\Model
{
    public function authenticate($apikey)
    {
        $user = User::where('apikey', '=', $apikey)->take(1)->get();
        
        
        if(isset($user[0])){
            $this->details = $user[0];
            return $this->details->id;

        }
        return false;
    }

    public function message()
    {
        return $this->hasMany("Appch\Models\Message");
    }
}