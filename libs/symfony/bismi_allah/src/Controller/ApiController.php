<?php
// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

// App\{dir_name}: php standards
namespace App\Controller;

use App\Repository\BismiAllahRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/api/')]
class ApiController extends AbstractController {

    #[Route('json')]
    public function getJson(BismiAllahRepository $bismi_allah_repository): Response {

        $bismi_allah_data = $bismi_allah_repository->findAll();

        return $this->json($bismi_allah_data);
    }

    #[Route('{id}', methods: ['GET'])]
    public function getById(int $id, BismiAllahRepository $bismi_allah_repository): Response {
        return $this->json($bismi_allah_repository->getId($id)); 
    }
}
