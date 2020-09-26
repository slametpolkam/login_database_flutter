<?php
class Pengguna extends CI_Controller
{
    public function __construct()
    {
    	parent::__construct();
        $this->load->model('PenggunaModel');
    }

	public function index()
	{
		$username = $_POST['username'];//$this->input->post('username');
		$password = md5($_POST['password']);//$this->input->post('password'));
		
		$cek =  $this->PenggunaModel->cek_user('pengguna',$username,$password)->num_rows();
			if($cek>0){
				$response="login berhasil";
				echo json_encode($response);
			}else {
			   	$response="login gagal";
				echo json_encode($response." dan ".$username);
			}
    }
    public function daftar(){
    	$username = $_POST['username'];//$this->input->post('username');
		$password = md5($_POST['password']);//$this->input->post('password'));
		$cek =  $this->PenggunaModel->cek_user('pengguna',$username,$password)->num_rows();

		if($cek>0){
				$response="tidak diizinkan";
				echo json_encode($response);
			}else{
				$this->db->query("insert into pengguna (id,username,sandi)values(NULL,'".$username."','".$password."')");
				$response="berhasil";
				echo json_encode($response." ".$username." ".$password);
			}
		}		

} 