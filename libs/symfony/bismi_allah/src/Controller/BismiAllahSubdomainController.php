<?php

// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed rassoul Allah

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

// #[Route(path: '/')]
class BismiAllahSubdomainController extends AbstractController
{

    #[Route(host: '{sub}.localhost', path: '/ads')]
    public function bismiAllah($sub): Response
    {
        return new Response('bismi Allah <br/>' . $sub);
    }
}

