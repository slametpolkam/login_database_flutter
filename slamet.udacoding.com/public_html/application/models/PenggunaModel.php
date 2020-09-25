<?php 
class PenggunaModel extends CI_Model {
	public function cek_user($tabel,$username,$sandi)
  		{
    		// return $query = $this->db->select()
    		//                   ->from($tabel)
    		//                   ->where($dimana)
    		//                   ->get();
			$query="select * from ".$tabel." where username='".$username."' AND sandi='".$sandi."'" ;
			return $this->db->query($query);
    		// return $query->result();
  		}
}