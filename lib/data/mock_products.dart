import '../models/product.dart';

const List<Product> mockProductList = [
  Product(
    id: 'prod_1',
    title: 'Casque Audio Sans Fil Pro ANC',
    description:
        'Profitez d\'un son haute fidélité avec réduction active du bruit (ANC). Autonomie impressionnante de 40 heures, coussinets à mémoire de forme ultra confortables et compatibilité Bluetooth 5.3.',
    price: 189.99,
    category: 'High-Tech',
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&auto=format&fit=crop&q=80',
    rating: 4.8,
    reviewCount: 245,
    isAvailable: true,
  ),
  Product(
    id: 'prod_2',
    title: 'Montre Connectée Sport & Santé',
    description:
        'Suivi précis de l\'activité physique, fréquence cardiaque en continu, capteur SpO2 et GPS intégré. Écran AMOLED lumineux de 1.4 pouce avec étanchéité 5 ATM.',
    price: 149.50,
    category: 'High-Tech',
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&auto=format&fit=crop&q=80',
    rating: 4.6,
    reviewCount: 189,
    isAvailable: true,
  ),
  Product(
    id: 'prod_3',
    title: 'Sneakers Urbaines Eco-Design',
    description:
        'Baskets tendance fabriquées à partir de matières recyclées premium. Semelle amortissante ergonomique idéale pour un port quotidien dynamique et élégant.',
    price: 89.00,
    category: 'Mode',
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800&auto=format&fit=crop&q=80',
    rating: 4.7,
    reviewCount: 312,
    isAvailable: true,
  ),
  Product(
    id: 'prod_4',
    title: 'Sac à Dos Minimaliste Imperméable',
    description:
        'Compartiment rembourré dédié aux ordinateurs jusqu\'à 16 pouces. Tissu déperlant haut de gamme avec fermetures étanches et poche antivol dissimulée.',
    price: 69.90,
    category: 'Mode',
    imageUrl:
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&auto=format&fit=crop&q=80',
    rating: 4.5,
    reviewCount: 98,
    isAvailable: true,
  ),
  Product(
    id: 'prod_5',
    title: 'Appareil Photo Rétro Instantané',
    description:
        'Capturez vos plus beaux moments avec charme et authenticité. Réglage automatique de l\'exposition, mode selfie intégré et flash intelligent.',
    price: 119.00,
    category: 'High-Tech',
    imageUrl:
        'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=800&auto=format&fit=crop&q=80',
    rating: 4.4,
    reviewCount: 142,
    isAvailable: true,
  ),
  Product(
    id: 'prod_6',
    title: 'Lampe de Bureau Design LED Tactile',
    description:
        'Éclairage anti-scintillement protégeant les yeux avec 5 températures de couleur et variateur d\'intensité. Socle avec chargeur sans fil Qi intégré.',
    price: 49.99,
    category: 'Maison',
    imageUrl:
        'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=800&auto=format&fit=crop&q=80',
    rating: 4.3,
    reviewCount: 76,
    isAvailable: true,
  ),
  Product(
    id: 'prod_7',
    title: 'Bouteille Isotherme Inox 750ml',
    description:
        'Garde vos boissons chaudes pendant 12 heures et fraîches pendant 24 heures. Acier inoxydable de qualité alimentaire, étanche et garanti sans BPA.',
    price: 28.50,
    category: 'Maison',
    imageUrl:
        'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=800&auto=format&fit=crop&q=80',
    rating: 4.9,
    reviewCount: 420,
    isAvailable: true,
  ),
  Product(
    id: 'prod_8',
    title: 'Clavier Mécanique Compact RGB',
    description:
        'Switches tactiles interchangeables à chaud pour une frappe ultra précise. Rétroéclairage RVB personnalisable par touche et structure en aluminium brossé.',
    price: 129.95,
    category: 'High-Tech',
    imageUrl:
        'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=800&auto=format&fit=crop&q=80',
    rating: 4.7,
    reviewCount: 204,
    isAvailable: true,
  ),
  Product(
    id: 'prod_9',
    title: 'Lunettes de Soleil Polarisées Polaris',
    description:
        'Protection UV400 intégrale avec verres polarisés haute définition réduisant l\'éblouissement. Monture ultra légère en titane noir mat.',
    price: 75.00,
    category: 'Mode',
    imageUrl:
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&auto=format&fit=crop&q=80',
    rating: 4.6,
    reviewCount: 88,
    isAvailable: true,
  ),
  Product(
    id: 'prod_10',
    title: 'Enceinte Bluetooth Étanche IPX7',
    description:
        'Son immersif à 360° avec des basses profondes. Conçue pour l\'aventure avec une autonomie de 16 heures et une résistance complète aux immersions dans l\'eau.',
    price: 59.99,
    category: 'High-Tech',
    imageUrl:
        'https://images.unsplash.com/photo-1545454675-3531b543be5d?w=800&auto=format&fit=crop&q=80',
    rating: 4.5,
    reviewCount: 167,
    isAvailable: true,
  ),
];

const List<String> mockCategories = [
  'Tous',
  'High-Tech',
  'Mode',
  'Maison',
];
