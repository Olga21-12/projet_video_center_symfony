<?php

namespace App\Controller;

use App\Data\SearchData;
use App\Entity\User;
use App\Entity\Video;
use Doctrine\ORM\EntityManagerInterface;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Form\SearchType;
use App\Repository\VideoRepository;
use Symfony\Component\Form\Extension\Core\Type\SearchType as TypeSearchType;

class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(
        VideoRepository $repository,
        EntityManagerInterface $em,
        PaginatorInterface $paginator,
        Request $request
    ): Response {

            /**
             * @var User
             */

        $user = $this->getUser();

        $isVerified = $user instanceof User && $user->isVerified();

        $searchData = new SearchData();
        $form = $this->createForm(SearchType::class, $searchData);
        $form->handleRequest($request);

        $queryBuilder = $repository->createQueryBuilder('v');

        if ($searchData->query) {
        $queryBuilder
            ->andWhere('v.title LIKE :q')
            ->setParameter('q', '%' . $searchData->query . '%');
    }

        $query = $em->getRepository(Video::class)
                    ->createQueryBuilder('v')
                    ->orderBy('v.createdAt', 'DESC')
                    ->getQuery();

        // фильтр по категориям
        $currentCategory = $request->query->get('category');
            if ($currentCategory) {
        $queryBuilder
            ->join('v.type', 't')
            ->andWhere('t.name = :cat')
            ->setParameter('cat', $currentCategory);
    }

        $queryBuilder->orderBy('v.createdAt', 'DESC');
        $query = $queryBuilder->getQuery();

        // пагинация
        $videos = $paginator->paginate(
            $query,
            $request->query->getInt('page', 1),
            9
        );

        $totalVideos = $repository->count([]);

        // категории
        $categories = $em->getRepository(Video::class)
            ->createQueryBuilder('v')
            ->select('t.name AS name, COUNT(v.id) as videoCount')
            ->join('v.type', 't')
            ->groupBy('t.id')
            ->getQuery()
            ->getResult();

        // случайные 3 видео для карусели
        $randomVideos = $em->getRepository(Video::class)->findAll();
            shuffle($randomVideos);
        $randomVideos = array_slice($randomVideos, 0, 3);

        return $this->render('home/index.html.twig', [

            'videos' => $videos,
            'searchForm' => $form->createView(),
            'totalVideo' => $totalVideos, // передаем количество
            'categories' => $categories,
            'randomVideos' => $randomVideos,
            'isVerified' => $isVerified,
            'currentCategory' => $currentCategory,
            
        ]);
    }
}