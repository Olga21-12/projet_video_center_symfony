<?php
namespace App\Controller;

use App\Entity\User;
use App\Form\UserType;
use App\Repository\VideoRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

use DateTimeImmutable;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorageInterface;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

use Symfony\Contracts\Translation\TranslatorInterface;

class ProfileController extends AbstractController
{
    #[Route('/profil', name: 'app_profile')]
    public function index(VideoRepository $videoRepository,
                          TranslatorInterface $translator,
                          PaginatorInterface $paginator,
                          Request $request): Response
    {

        /** @var \App\Entity\User $user */

        $user = $this->getUser();

        if (!$user) {
        $this->addFlash('error', $translator->trans('Vous devez être connecté pour accéder à votre profil.'));
        return $this->redirectToRoute('app_login');
    }

        if (!$user->isVerified()) {
            $this->addFlash("info","Votre adresse email n'est pas vérifiée !");
    }

    $query = $videoRepository->createQueryBuilder('v')
        ->where('v.user = :user')
        ->setParameter('user', $user)
        ->orderBy('v.createdAt', 'DESC');

    $pagination = $paginator->paginate(
        $query->getQuery(),
        $request->query->getInt('page', 1),
        6
    );

        // Группировка по типам
        $popularTypes = [];
    foreach ($user->getVideos() as $video) {
        $typeName = $video->getType()->getName();
        $popularTypes[$typeName] = ($popularTypes[$typeName] ?? 0) + 1;
    }
    $popularTypes = array_filter($popularTypes, fn($count) => $count >= 3);

  
        return $this->render('profile/index.html.twig', [
            'user' => $user,
            'videos' => $pagination,
            'videoCount' => count($user->getVideos()),
            'popularTypes' => array_keys($popularTypes)
        ]);
    }

    #[Route('/profil/edit', name: 'app_profile_edit')]
    public function edit(Request $request, EntityManagerInterface $entityManager,
                         TranslatorInterface $translator): Response
    {
        /** @var User $user */
        $user = $this->getUser();

        if (!$user) {
            $this->addFlash('info', $translator->trans('Vous devez être connecté pour modifier votre profil.'));
            return $this->redirectToRoute('app_login');
        }

        if (!$user->isVerified()) {
        $this->addFlash('info', $translator->trans('Vous devez confirmer votre adresse e-mail avant de pouvoir modifier votre profil.'));
        return $this->redirectToRoute('app_profile');
        }

        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();
            $this->addFlash('success', $translator->trans('Profil mis à jour avec succès.'));
            return $this->redirectToRoute('app_profile');
        }

        return $this->render('user/edit.html.twig', [
            'form' => $form,
        ]);
    }

    #[Route('/profil/delete', name: 'app_profile_delete')]
    public function delete(Request $request, EntityManagerInterface $entityManager, TranslatorInterface $translator,
                            TokenStorageInterface $tokenStorage, SessionInterface $session): Response
    {
        /** @var User $user */
        $user = $this->getUser();

        if (!$user) {
            $this->addFlash('error', $translator->trans('Vous devez être connecté pour supprimer votre compte.'));
            return $this->redirectToRoute('app_login');
        }

        if (!$user->isVerified()) {
        $this->addFlash('info', $translator->trans('Vous devez confirmer votre adresse e-mail avant de pouvoir modifier votre profil.'));
        return $this->redirectToRoute('app_profile');
        }

        if ($this->isCsrfTokenValid('delete'.$user->getId(), $request->get('_token'))) {

            // TODO: удалить фото и видео пользователя
           // $entityManager->remove($user);
           // $entityManager->flush();

            // Разлогиниваем пользователя
            $tokenStorage->setToken(null);
            $session->invalidate();

            $this->addFlash('success', $translator->trans('Votre compte a été supprimé.'));
            return $this->redirectToRoute('app_home');
        }

        $this->addFlash('error', $translator->trans('Action non autorisée.'));
        return $this->redirectToRoute('app_profile');
    }
}
