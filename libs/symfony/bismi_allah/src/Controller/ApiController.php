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

    #[Route('all', methods: ['GET'])]
    public function getJson(BismiAllahRepository $bismi_allah_repository): Response {

        $bismi_allah_data = $bismi_allah_repository->findAll();

        return $this->json($bismi_allah_data);
    }

    // #[Route('{id<\d+>}')]
    #[Route('{id<\d+>}', methods: ['GET'])]
    public function getById(int $id, BismiAllahRepository $bismi_allah_repository): Response {
        $respone = $bismi_allah_repository->getId($id);

        if(!$respone) throw $this->createNotFoundException('BismiAllah object not found');

        return $this->json($respone);

        // could be 
        // return $this->json(
        //   $bismi_allah_repository->getId($id) ?? throw $this->createNotFoundException('BismiAllah object not found')
        // ); 
        // but why would I?
    }
}
