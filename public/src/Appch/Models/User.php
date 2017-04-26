<?php

namespace Appch\Models;

class User extends \Illuminate\Database\Eloquent\Model {

    public function login($user, $pass){
        $userLoged = User::where('email', '=', $user)->take(1)->get();

        $userPassword=$userLoged[0]->getAttributes()['password'];
        if(!password_verify($pass, $userPassword)){
            return false;
        }

        return $userLoged[0];

    }

    public function authenticate($apikey)
    {
        $user = User::where('apikey', '=', $apikey)->take(1)->get();
        
        
        if(isset($user[0])){
            $this->details = $user[0];
            return $this->details->id;

        }
        return false;
    }

    public function pagamento()
    {
        return $this->hasMany("Appch\Models\Pagamento");
    }
}