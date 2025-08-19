<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Vich\UploaderBundle\Form\Type\VichImageType;

class UserType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $isAdmin = $options['is_admin'] ?? false;

        $builder
            ->add('firstname', TextType::class, [
                'label' => 'userForm.firstname',
            ])
            ->add('lastname', TextType::class, [
                'label' => 'userForm.lastname',
            ])
            ->add('email', EmailType::class, [
                'label' => 'userForm.email',
            ])
            ->add('imageFile', VichImageType::class, [
                'required' => false,
                'allow_delete' => true,
                'delete_label'=> 'Delete profile image',
                'download_uri' => true,
                'image_uri' => true,
                'asset_helper'=> true,
                'imagine_pattern' => 'avatar_thumbnail'
            ]);

        if ($isAdmin) {
            $builder
                ->add('roles')
                ->add('isVerified');
        }

        // Пароль добавляем только при создании или смене
        if ($options['include_password']) {
            $builder->add('plainPassword', PasswordType::class, [
                'mapped' => false,
                'required' => false,
            ]);
        }
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => User::class,
            'is_admin' => false,
            'include_password' => false,
        ]);
    }
}
