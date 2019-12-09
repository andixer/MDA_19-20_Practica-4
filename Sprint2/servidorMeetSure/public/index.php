<?php
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;

require __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/../php/gestorBD.php';
require_once __DIR__ . '/../php/actividad.php';
require_once __DIR__ . '/../php/usuario.php';

$app = AppFactory::create();

function setResponse(Response $response, $array_body, int $status) {
    $response = $response -> withHeader('Content-type', 'application/json') -> withStatus($status);
    $body = json_encode($array_body);

    $response -> getBody() -> write($body);

    return $response;
}

$app->post('/regsitrar', function (Request $request, Response $response, $args) {
    $conexion_bd= new gestorBD();
    $user = new Usuario;
    $post = $request->getBody();
    $post=json_decode($post,true);

    $user->Nombre= $post['nick'];
    $user->Email= $post['email'];
    $user->Password = $post['password'];
    
    $exito=$conexion_bd->regUsuario($user);
    if ($exito){
        $response = setResponse($response, array ("description"=>"OK"),200);
    }
    else{
        $response = setResponse($response, array ("description"=>"NOT OK"),400);
    }
    return $response;
});

$app->post('/identificarse', function (Request $request, Response $response, $args) {
    $conexion_bd= new gestorBD();
    $user = new Usuario;
    $post = $request->getBody();
    $post=json_decode($post,true);

    $user->Email= $post['email'];
    $user->Password = $post['password'];
    
    $exito=$conexion_bd->identificarUsuario($user);
    if ($exito){
        $response = setResponse($response, array ("description"=>"OK"),200);
    }
    else{
        $response = setResponse($response, array ("description"=>"NOT OK"),400);
    }
    return $response;
});

$app->get('/actividad/{id_actividad}', function (Request $request, Response $response, $args) {
    $conexion_bd= new gestorBD();
    $actividad = new Actividad;
    $actividad->ActividadID = $args['id_actividad'];
    $actividad=$conexion_bd->getActividad($actividad);
    $response = setResponse($response,array("actividad"=>$actividad), 200);

    return $response;
});

$app->put('/actividad/apuntarse/{id_actividad}', function (Request $request, Response $response, $args) {
    $conexion_bd= new gestorBD();
    $actividad = new Actividad;
    $actividad->ActividadID = $args['id_actividad'];
    $actividad=$conexion_bd->apuntarseActividad($actividad);
    $response = setResponse($response,array("actividad"=>$actividad), 200);

    return $response;
});

$app->post('/actividad', function (Request $request, Response $response, $args) {
    $conexion_bd= new gestorBD();
    $actividad= new Actividad;

    $post = $request->getBody();
    $post=json_decode($post,true);

    $actividad->Nombre=$post['nombre'];
    $actividad->Descripcion=$post['descripcion'];
    $actividad->Fecha=$post['fecha'];
    $actividad->Hora=$post['hora'];
    $actividad->Lugar=$post['lugar'];
    $actividad->MinimoParticipantes=$post['minimo_participantes'];
    $actividad->MaximoParticipantes=$post['maximo_participantes'];
    
    $exito=$conexion_bd->regActividad($actividad);
    if ($exito){
        $response = setResponse($response, array ("description"=>"OK"),200);
    }
    else{
        $response = setResponse($response, array ("description"=>"NOT OK"),400);
    }
    return $response;
});

$app->get('/listaActividades', function (Request $request, Response $response, $args) {
    $conexion_bd= new gestorBD();
    $listaActividades=array();
    $conexion_bd= new gestorBD();
    $listaActividades=$conexion_bd->getListaActividades();
    $response = setResponse($response,array("actividades"=>$listaActividades), 200);
    return $response;
});

$app->run();

