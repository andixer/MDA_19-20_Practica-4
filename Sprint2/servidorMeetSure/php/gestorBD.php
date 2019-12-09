<?php
	class gestorBD{
		private $conexion;
		public function __construct(){
			$host='localhost';
			$user='meetsure_admin';
			$pass='12341234#MeetSure';
			$DB='MeetSure';
			$this->conexion = new mysqli ($host, $user, $pass, $DB);
			$this->conexion->set_charset("utf8");
			if ($this->conexion->connect_error){
		    	echo "Conexion a BD fallida";
		    	exit();
			}
		}

		public function close(){
			mysqli_close($this->conexion);
		}
		
		public function regUsuario($usuario){
			$exito=false;
			$consulta=$this->conexion->prepare("INSERT INTO Usuarios (nombre, email, contraseña)
			 VALUES (?,?,?);");
			$consulta->bind_param("sss",$usuario->nombre,$usuario->email, $usuario->password);
			$consulta->execute();
			$exito=$consulta->affected_rows;
			return $exito;
		}

		public function identificarUsuario($usuario){
			$exito=false;
			$consulta=$this->conexion->prepare("SELECT * FROM Usuarios WHERE Nombre=? AND Password=?;");
			$consulta->bind_param("ss",$usuario->email,$usuario->password);
			$consulta->execute();
			if($consulta->get_result()->num_rows){
				$exito=true;
			}
			return $exito;
		}

		public function regActividad($actividad){
			$exito = false;
			$consulta=$this->conexion->prepare("INSERT INTO Actividades (Nombre,Descripcion,Fecha,Hora,Lugar,MinimoParticpantes,MaximoParticipantes) VALUES(?,?,?,?,?,?,?);");
			$consulta->bind_param("sssssii",$actividad->Nombre,$actividad->Descripcion,$actividad->Fecha,$actividad->Hora,$actividad->Lugar,$actvidad->MinimoParticipantes,$actividad->MaximoParticipantes);
			$consulta->execute();
			return ($consulta->affected_rows!=-1);
		}

		public function getListaActividades(){

		}

		public function getActividad($actividad){

		}

		public function apuntarseActividad($actividad){
			
		}
	}
?>
