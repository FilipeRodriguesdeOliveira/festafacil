import React, { useState, useEffect, createContext, useContext } from 'react';
import { ShoppingCart, Search, Menu, X, Star, Calendar, MapPin, Users, Package, Sparkles, Heart, MessageCircle, Bell, User, LogOut, Home, Store, Settings, Award, CreditCard, Filter, ChevronRight, Check, Plus, Minus, ArrowLeft, Phone, Mail, TrendingUp, DollarSign, BarChart3, Zap, Camera, Music, Cake, PartyPopper, Gift, Crown, Target, PieChart, Activity, RefreshCw, Send, Bot, CheckCircle, XCircle, AlertCircle, Briefcase, UserPlus, Clock, Edit, Trash2, Eye, Download, Upload } from 'lucide-react';

const AppContext = createContext();
const useApp = () => useContext(AppContext);

const TIPOS_FESTA = ['Infantil', 'Aniversário Adulto', 'Casamento', '15 Anos', 'Corporativo', 'Formatura', 'Chá de Bebê', 'Chá Revelação', 'Bodas', 'Temática Geek', 'Festa Junina', 'Natal', 'Réveillon'];

const PACOTES = {
  'Infantil': {
    basico: { nome: 'Básico Infantil', nivel: 'basico', descricao: 'Festa simples e divertida', itens: ['Decoração simples', 'Mesa bolo', 'Bolo 2kg', '200 salgados', 'Som'], tempoHoras: 4, convidadosMin: 30, convidadosMax: 50, valorBase: 180000, precoPorPessoa: 5000, upgrades: ['DJ +R$500', 'Personagem +R$600'] },
    premium: { nome: 'Premium Infantil', nivel: 'premium', descricao: 'Diversão completa', itens: ['Decoração temática', 'Buffet', 'DJ', 'Recreadores', 'Brinquedos'], tempoHoras: 5, convidadosMin: 50, convidadosMax: 100, valorBase: 450000, precoPorPessoa: 7500, upgrades: ['Personagens +R$800', 'Cabine fotos +R$600'] },
    luxo: { nome: 'Luxo Infantil', nivel: 'luxo', descricao: 'Festa dos sonhos', itens: ['Cenografia', 'Buffet gourmet', 'DJ + Iluminação', 'Personagens', 'Todos brinquedos', 'Cabine 360', 'Foto + vídeo'], tempoHoras: 6, convidadosMin: 100, convidadosMax: 200, valorBase: 1200000, precoPorPessoa: 12000, upgrades: ['Food truck +R$1.500'] }
  },
  'Casamento': {
    basico: { nome: 'Básico Casamento', nivel: 'basico', descricao: 'Elegância simples', itens: ['Decoração elegante', 'Buffet jantar', 'Som', 'Iluminação'], tempoHoras: 5, convidadosMin: 50, convidadosMax: 100, valorBase: 1200000, precoPorPessoa: 18000, upgrades: ['Fotógrafo +R$1.500', 'DJ +R$1.000'] },
    premium: { nome: 'Premium Casamento', nivel: 'premium', descricao: 'Casamento completo', itens: ['Decoração luxo', 'Buffet premium', 'Banda/DJ', 'Iluminação', 'Fotógrafo', 'Open bar'], tempoHoras: 6, convidadosMin: 100, convidadosMax: 200, valorBase: 2800000, precoPorPessoa: 28000, upgrades: ['Vídeo 4K +R$2.500', 'Drone +R$1.800'] },
    luxo: { nome: 'Luxo Casamento', nivel: 'luxo', descricao: 'Perfeição total', itens: ['Cenografia', 'Buffet gourmet', 'Banda + DJ', 'Iluminação pro', 'Foto + vídeo', 'Drone', 'Open bar premium', 'Valet'], tempoHoras: 8, convidadosMin: 200, convidadosMax: 400, valorBase: 6500000, precoPorPessoa: 42000, upgrades: ['Mapping 3D +R$5.000'] }
  }
};

const SERVICOS = [
  { id: '1', titulo: 'Decoração Frozen Luxo', descricao: 'Decoração completa tema Frozen', valor: 350000, categoria: 'Decoração', tipoDeFesta: ['Infantil'], cidade: 'São Paulo', rating: 4.9, imagem: 'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=400', fornecedor: 'Festa Mágica', destaque: true },
  { id: '2', titulo: 'DJ Premium', descricao: 'DJ com equipamento profissional', valor: 180000, categoria: 'Entretenimento', tipoDeFesta: ['Aniversário Adulto', 'Casamento'], cidade: 'Rio de Janeiro', rating: 5.0, imagem: 'https://images.unsplash.com/photo-1571266028243-d220c6eb2f82?w=400', fornecedor: 'Sound Masters' },
  { id: '3', titulo: 'Buffet Gourmet', descricao: 'Menu completo internacional', valor: 12000, categoria: 'Gastronomia', tipoDeFesta: ['Casamento'], cidade: 'São Paulo', rating: 4.8, imagem: 'https://images.unsplash.com/photo-1555244162-803834f70033?w=400', fornecedor: 'Sabor Arte', destaque: true },
  { id: '4', titulo: 'Foto + Vídeo 4K', descricao: 'Cobertura completa profissional', valor: 450000, categoria: 'Registro', tipoDeFesta: ['Casamento', '15 Anos'], cidade: 'Brasília', rating: 5.0, imagem: 'https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?w=400', fornecedor: 'Momentos Eternos' }
];

const formatCurrency = (cents) => new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(cents / 100);

function FestaFacilApp() {
  const [showIntro, setShowIntro] = useState(true);
  const [currentScreen, setCurrentScreen] = useState('home');
  const [user, setUser] = useState(null);
  const [cart, setCart] = useState([]);
  const [favorites, setFavorites] = useState([]);
  const [showMenu, setShowMenu] = useState(false);
  const [selectedItem, setSelectedItem] = useState(null);
  const [chatMessages, setChatMessages] = useState([]);
  const [pontos, setPontos] = useState(0);

  useEffect(() => {
    const timer = setTimeout(() => setShowIntro(false), 5000);
    return () => clearTimeout(timer);
  }, []);

  const addToCart = (item) => {
    setCart([...cart, { ...item, cartId: Date.now() }]);
    alert('✅ Adicionado ao carrinho!');
  };

  const removeFromCart = (cartId) => {
    setCart(cart.filter(item => item.cartId !== cartId));
  };

  const toggleFavorite = (itemId) => {
    setFavorites(favorites.includes(itemId) ? favorites.filter(id => id !== itemId) : [...favorites, itemId]);
  };

  const login = (userData) => {
    setUser(userData);
    setCurrentScreen('home');
    setShowMenu(false);
  };

  const logout = () => {
    setUser(null);
    setCart([]);
    setCurrentScreen('home');
    setShowMenu(false);
  };

  const contextValue = { currentScreen, setCurrentScreen, user, login, logout, cart, addToCart, removeFromCart, favorites, toggleFavorite, showMenu, setShowMenu, selectedItem, setSelectedItem, chatMessages, setChatMessages, pontos, setPontos };

  return (
    <AppContext.Provider value={contextValue}>
      {showIntro ? <IntroScreen /> : (
        <div className="min-h-screen bg-gradient-to-br from-purple-950 via-purple-900 to-pink-900">
          <Header />
          <main className="pb-20">
            {currentScreen === 'home' && <HomeScreen />}
            {currentScreen === 'catalogo' && <CatalogoScreen />}
            {currentScreen === 'pacotes' && <PacotesScreen />}
            {currentScreen === 'detalhe-pacote' && <DetalhePacoteScreen />}
            {currentScreen === 'carrinho' && <CarrinhoScreen />}
            {currentScreen === 'perfil' && <PerfilScreen />}
            {currentScreen === 'login' && <LoginScreen />}
            {currentScreen === 'detalhe-servico' && <DetalheServicoScreen />}
            {currentScreen === 'chat-ia' && <ChatIAScreen />}
            {currentScreen === 'montar-festa' && <MontarFestaScreen />}
          </main>
          <BottomNav />
          <MenuDrawer />
        </div>
      )}
    </AppContext.Provider>
  );
}

function IntroScreen() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-950 via-purple-900 to-pink-900 flex items-center justify-center overflow-hidden">
      <style>{`
        @keyframes balloonRise {
          0% { transform: translateY(0) scale(1); opacity: 1; }
          40% { transform: translateY(-150px) scale(1.1); opacity: 1; }
          50% { transform: translateY(-150px) scale(1.3); opacity: 0.8; }
          60% { transform: translateY(-150px) scale(0); opacity: 0; }
          100% { transform: translateY(-150px) scale(0); opacity: 0; }
        }

        @keyframes confettiExplode {
          0% { transform: translate(0, 0) scale(0) rotate(0deg); opacity: 0; }
          50% { opacity: 1; }
          100% { transform: translate(var(--tx), var(--ty)) scale(1) rotate(var(--r)); opacity: 0; }
        }

        @keyframes textSpin {
          0% { transform: rotateY(0deg) scale(1); opacity: 1; }
          30% { transform: rotateY(180deg) scale(0.8); opacity: 0.3; }
          50% { transform: rotateY(360deg) scale(1); opacity: 1; }
          100% { transform: rotateY(360deg) scale(1); opacity: 1; }
        }

        @keyframes slideUp {
          0% { transform: translateY(100px); opacity: 0; }
          60% { transform: translateY(100px); opacity: 0; }
          100% { transform: translateY(0); opacity: 1; }
        }

        @keyframes fadeOut {
          0% { opacity: 1; }
          90% { opacity: 1; }
          100% { opacity: 0; }
        }

        .balloon-container { animation: balloonRise 2s ease-out forwards; }
        .confetti { position: absolute; width: 12px; height: 12px; border-radius: 50%; animation: confettiExplode 1.5s ease-out forwards; animation-delay: 1.2s; }
        .confetti-1 { background: #FF2E93; --tx: -120px; --ty: -80px; --r: 360deg; top: 35%; left: 50%; }
        .confetti-2 { background: #FFC107; --tx: 130px; --ty: -100px; --r: -270deg; top: 35%; left: 50%; }
        .confetti-3 { background: #FF2E93; --tx: -90px; --ty: 70px; --r: 180deg; top: 35%; left: 50%; }
        .confetti-4 { background: #FFC107; --tx: 100px; --ty: 90px; --r: -180deg; top: 35%; left: 50%; }
        .confetti-5 { background: #A78BFA; --tx: 0px; --ty: -120px; --r: 360deg; top: 35%; left: 50%; }
        .confetti-6 { background: #FF2E93; --tx: -150px; --ty: 20px; --r: 270deg; top: 35%; left: 50%; }
        .confetti-7 { background: #FFC107; --tx: 150px; --ty: -30px; --r: -360deg; top: 35%; left: 50%; }
        .confetti-8 { background: #A78BFA; --tx: -60px; --ty: -150px; --r: 180deg; top: 35%; left: 50%; }
        .star-confetti { position: absolute; color: #FF2E93; animation: confettiExplode 1.5s ease-out forwards; animation-delay: 1.2s; }
        .star-1 { --tx: -180px; --ty: -50px; --r: 540deg; top: 35%; left: 50%; }
        .star-2 { --tx: 170px; --ty: 40px; --r: -540deg; top: 35%; left: 50%; }
        .text-container { animation: textSpin 2.5s ease-in-out forwards; transform-style: preserve-3d; }
        .tagline { animation: slideUp 2s ease-out forwards; }
        .intro-wrapper { animation: fadeOut 5s ease-out forwards; }
      `}</style>

      <div className="intro-wrapper relative">
        <div className="relative flex flex-col items-center">
          <div className="balloon-container mb-8">
            <svg width="120" height="140" viewBox="0 0 120 140" fill="none">
              <ellipse cx="60" cy="60" rx="50" ry="55" fill="url(#balloonGradient)" />
              <path d="M60 115 Q55 125, 60 135" stroke="#8B5CF6" strokeWidth="3" fill="none" />
              <ellipse cx="45" cy="45" rx="15" ry="20" fill="white" opacity="0.3" />
              <defs>
                <linearGradient id="balloonGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                  <stop offset="0%" stopColor="#A78BFA" />
                  <stop offset="100%" stopColor="#8B5CF6" />
                </linearGradient>
              </defs>
            </svg>
          </div>

          <div className="confetti confetti-1"></div>
          <div className="confetti confetti-2"></div>
          <div className="confetti confetti-3"></div>
          <div className="confetti confetti-4"></div>
          <div className="confetti confetti-5"></div>
          <div className="confetti confetti-6"></div>
          <div className="confetti confetti-7"></div>
          <div className="confetti confetti-8"></div>

          <svg className="star-confetti star-1" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 2L15 9L22 9L16.5 14L19 21L12 16L5 21L7.5 14L2 9L9 9L12 2Z" />
          </svg>
          <svg className="star-confetti star-2" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 2L15 9L22 9L16.5 14L19 21L12 16L5 21L7.5 14L2 9L9 9L12 2Z" />
          </svg>

          <div className="text-container text-center mb-6">
            <h1 className="text-7xl font-bold mb-2">
              <span className="text-pink-500">Festa</span>
              <br />
              <span className="text-yellow-400">Fácil</span>
            </h1>
            <p className="text-white text-2xl font-semibold">Group</p>
          </div>

          <div className="tagline">
            <p className="text-white text-xl font-bold text-center px-8 py-4 bg-pink-500/20 rounded-2xl border border-pink-500/40 backdrop-blur">
              O melhor aplicativo de festa do Brasil
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

function Header() {
  const { setShowMenu, cart, pontos } = useApp();
  return (
    <header className="bg-purple-950 border-b border-pink-500/30 sticky top-0 z-40">
      <div className="max-w-7xl mx-auto px-4 py-4 flex items-center justify-between">
        <button onClick={() => setShowMenu(true)} className="text-white"><Menu size={24} /></button>
        <div className="flex items-center gap-2">
          <PartyPopper className="text-yellow-400" size={28} />
          <h1 className="text-2xl font-bold text-white">Festa Fácil</h1>
        </div>
        <div className="flex items-center gap-3">
          {pontos > 0 && (
            <div className="bg-yellow-500/20 px-3 py-1 rounded-full flex items-center gap-1">
              <Sparkles className="text-yellow-400" size={16} />
              <span className="text-yellow-400 font-bold text-sm">{pontos}</span>
            </div>
          )}
          <button className="text-white relative">
            <ShoppingCart size={22} />
            {cart.length > 0 && <span className="absolute -top-2 -right-2 bg-pink-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center font-bold">{cart.length}</span>}
          </button>
        </div>
      </div>
    </header>
  );
}

function BottomNav() {
  const { currentScreen, setCurrentScreen, user } = useApp();
  const navItems = [
    { id: 'home', icon: Home, label: 'Início' },
    { id: 'catalogo', icon: Store, label: 'Catálogo' },
    { id: 'pacotes', icon: Package, label: 'Pacotes' },
    { id: 'carrinho', icon: ShoppingCart, label: 'Carrinho' },
    { id: user ? 'perfil' : 'login', icon: User, label: user ? 'Perfil' : 'Entrar' }
  ];

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-purple-950 border-t border-pink-500/30 z-50">
      <div className="max-w-7xl mx-auto px-2 flex justify-around py-2">
        {navItems.map(item => (
          <button key={item.id} onClick={() => setCurrentScreen(item.id)} className={`flex flex-col items-center gap-1 px-3 py-2 rounded-lg transition-colors ${currentScreen === item.id ? 'text-pink-500 bg-pink-500/10' : 'text-gray-300'}`}>
            <item.icon size={20} />
            <span className="text-xs font-medium">{item.label}</span>
          </button>
        ))}
      </div>
    </nav>
  );
}

function MenuDrawer() {
  const { showMenu, setShowMenu, user, logout, setCurrentScreen } = useApp();
  if (!showMenu) return null;

  return (
    <div className="fixed inset-0 z-50">
      <div className="absolute inset-0 bg-black/70" onClick={() => setShowMenu(false)}></div>
      <div className="absolute left-0 top-0 bottom-0 w-80 bg-purple-950 overflow-y-auto">
        <div className="p-6">
          <div className="flex items-center justify-between mb-8">
            <h2 className="text-2xl font-bold text-white">Menu</h2>
            <button onClick={() => setShowMenu(false)} className="text-white"><X size={24} /></button>
          </div>
          {user ? (
            <div className="mb-8 p-4 bg-pink-500/10 rounded-lg border border-pink-500/30">
              <div className="flex items-center gap-3 mb-2">
                <div className="w-12 h-12 bg-gradient-to-br from-pink-500 to-yellow-500 rounded-full flex items-center justify-center text-white font-bold text-xl">{user.nome[0]}</div>
                <div><p className="text-white font-semibold">{user.nome}</p><p className="text-gray-400 text-sm">{user.email}</p></div>
              </div>
            </div>
          ) : (
            <button onClick={() => { setCurrentScreen('login'); setShowMenu(false); }} className="w-full mb-8 px-6 py-3 bg-gradient-to-r from-pink-500 to-yellow-500 text-white font-bold rounded-lg">Entrar / Cadastrar</button>
          )}
          <div className="space-y-2">
            <MenuLink icon={Home} label="Início" onClick={() => { setCurrentScreen('home'); setShowMenu(false); }} />
            <MenuLink icon={Store} label="Catálogo" onClick={() => { setCurrentScreen('catalogo'); setShowMenu(false); }} />
            <MenuLink icon={Package} label="Pacotes" onClick={() => { setCurrentScreen('pacotes'); setShowMenu(false); }} />
            <MenuLink icon={Bot} label="Chat IA" onClick={() => { setCurrentScreen('chat-ia'); setShowMenu(false); }} />
          </div>
          {user && (
            <button onClick={logout} className="w-full mt-8 px-6 py-3 bg-red-500/20 text-red-400 font-semibold rounded-lg border border-red-500/30 flex items-center justify-center gap-2">
              <LogOut size={18} />Sair
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

function MenuLink({ icon: Icon, label, onClick }) {
  return <button onClick={onClick} className="w-full flex items-center gap-3 px-4 py-3 text-gray-300 hover:text-white hover:bg-pink-500/10 rounded-lg transition-colors"><Icon size={20} /><span className="font-medium">{label}</span></button>;
}

function HomeScreen() {
  const { setCurrentScreen, user, pontos } = useApp();
  const isVIP = pontos >= 100;

  return (
    <div className="max-w-7xl mx-auto px-4 py-6 space-y-8">
      <div className="relative bg-gradient-to-r from-pink-600 to-purple-600 rounded-3xl p-8">
        <h2 className="text-3xl font-bold text-white mb-3">🎉 Sua festa perfeita começa aqui!</h2>
        <p className="text-white/90 mb-6 text-lg">Serviços completos e pacotes personalizados</p>
        <div className="flex flex-wrap gap-3">
          <button onClick={() => setCurrentScreen('montar-festa')} className="px-6 py-3 bg-white text-purple-900 font-bold rounded-lg hover:shadow-xl transition-all flex items-center gap-2">
            <Sparkles size={20} />Monte sua Festa
          </button>
          <button onClick={() => setCurrentScreen('pacotes')} className="px-6 py-3 bg-yellow-400 text-purple-900 font-bold rounded-lg">Ver Pacotes</button>
          <button onClick={() => setCurrentScreen('catalogo')} className="px-6 py-3 bg-pink-500 text-white font-bold rounded-lg">Explorar Serviços</button>
          <button onClick={() => setCurrentScreen('chat-ia')} className="px-6 py-3 bg-purple-500 text-white font-bold rounded-lg flex items-center gap-2"><Bot size={20} />Assistente IA</button>
        </div>
      </div>

      {!isVIP && (
        <div className="bg-gradient-to-r from-yellow-500 to-orange-500 rounded-2xl p-6 border-2 border-yellow-300 shadow-xl">
          <div className="flex items-center gap-4">
            <Crown className="text-white" size={56} />
            <div className="flex-1">
              <h3 className="text-white text-2xl font-bold mb-2">🎁 Seja um Assinante VIP!</h3>
              <p className="text-white/90 mb-3">Desbloqueie descontos exclusivos de até 15% em todos os serviços e pacotes!</p>
              <ul className="text-white text-sm space-y-1 mb-4">
                <li>✓ 15% de desconto em tudo</li>
                <li>✓ Cashback de 5% em pontos</li>
                <li>✓ Acesso antecipado a promoções</li>
                <li>✓ Consultoria IA ilimitada</li>
                <li>✓ Suporte prioritário 24/7</li>
              </ul>
              <button className="px-6 py-3 bg-white text-orange-600 font-bold rounded-lg hover:shadow-lg transition-all">
                Assinar por R$ 29,90/mês
              </button>
            </div>
          </div>
        </div>
      )}

      <div>
        <h3 className="text-white text-2xl font-bold mb-4 flex items-center gap-2"><Sparkles className="text-yellow-400" />Pacotes em Destaque</h3>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <PacoteCard pacote={PACOTES['Infantil'].premium} tipoDeFesta="Infantil" />
          <PacoteCard pacote={PACOTES['Casamento'].luxo} tipoDeFesta="Casamento" />
          <PacoteCard pacote={PACOTES['Infantil'].luxo} tipoDeFesta="Infantil" />
        </div>
      </div>

      <div>
        <h3 className="text-white text-2xl font-bold mb-4">Serviços em Destaque</h3>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {SERVICOS.filter(s => s.destaque).map(servico => <ServicoCard key={servico.id} servico={servico} />)}
        </div>
      </div>
    </div>
  );
}

function PacoteCard({ pacote, tipoDeFesta }) {
  const { setCurrentScreen, setSelectedItem } = useApp();
  const nivelColors = { basico: 'from-blue-500 to-cyan-500', premium: 'from-purple-500 to-pink-500', luxo: 'from-yellow-500 to-orange-500' };
  return (
    <div onClick={() => { setSelectedItem({ ...pacote, tipoDeFesta }); setCurrentScreen('detalhe-pacote'); }} className="bg-purple-900/50 rounded-2xl overflow-hidden border border-pink-500/30 hover:border-pink-500 cursor-pointer">
      <div className={`h-32 bg-gradient-to-br ${nivelColors[pacote.nivel]} flex items-center justify-center`}><Package className="text-white" size={48} /></div>
      <div className="p-4">
        <h4 className="text-white font-bold text-lg mb-2">{pacote.nome}</h4>
        <p className="text-gray-300 text-sm mb-3">{pacote.descricao}</p>
        <p className="text-pink-500 font-bold text-xl">{formatCurrency(pacote.valorBase)}</p>
      </div>
    </div>
  );
}

function ServicoCard({ servico }) {
  const { setCurrentScreen, setSelectedItem, toggleFavorite, favorites } = useApp();
  return (
    <div onClick={() => { setSelectedItem(servico); setCurrentScreen('detalhe-servico'); }} className="bg-purple-900/50 rounded-2xl overflow-hidden border border-pink-500/30 hover:border-pink-500 cursor-pointer">
      <div className="relative h-48"><img src={servico.imagem} alt={servico.titulo} className="w-full h-full object-cover" />
        {servico.destaque && <span className="absolute top-3 left-3 px-3 py-1 bg-yellow-400 text-purple-900 text-xs font-bold rounded-full">DESTAQUE</span>}
        <button onClick={(e) => { e.stopPropagation(); toggleFavorite(servico.id); }} className="absolute top-3 right-3 p-2 bg-black/50 rounded-full text-white"><Heart size={20} fill={favorites.includes(servico.id) ? 'currentColor' : 'none'} /></button>
      </div>
      <div className="p-4">
        <h4 className="text-white font-bold text-lg mb-1">{servico.titulo}</h4>
        <p className="text-gray-400 text-sm mb-3">{servico.descricao}</p>
        <p className="text-pink-500 font-bold text-xl">{formatCurrency(servico.valor)}</p>
      </div>
    </div>
  );
}

function CatalogoScreen() {
  return (
    <div className="max-w-7xl mx-auto px-4 py-6">
      <h2 className="text-white text-3xl font-bold mb-6">Catálogo de Serviços</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {SERVICOS.map(servico => <ServicoCard key={servico.id} servico={servico} />)}
      </div>
    </div>
  );
}

function PacotesScreen() {
  return (
    <div className="max-w-7xl mx-auto px-4 py-6">
      <h2 className="text-white text-3xl font-bold mb-6">Pacotes de Festa</h2>
      {Object.entries(PACOTES).map(([tipoFesta, pacotes]) => (
        <div key={tipoFesta} className="mb-8">
          <h3 className="text-white text-2xl font-bold mb-4">{tipoFesta}</h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {Object.entries(pacotes).map(([nivel, pacote]) => <PacoteCard key={nivel} pacote={pacote} tipoDeFesta={tipoFesta} />)}
          </div>
        </div>
      ))}
    </div>
  );
}

function DetalhePacoteScreen() {
  const { selectedItem, setCurrentScreen, addToCart } = useApp();
  const [qtdConvidados, setQtdConvidados] = useState(50);

  if (!selectedItem) {
    setCurrentScreen('pacotes');
    return null;
  }

  const valorTotal = selectedItem.valorBase + (selectedItem.precoPorPessoa * qtdConvidados);

  return (
    <div className="max-w-4xl mx-auto px-4 py-6">
      <button onClick={() => setCurrentScreen('pacotes')} className="flex items-center gap-2 text-pink-400 mb-6"><ArrowLeft size={20} />Voltar</button>
      <h1 className="text-white text-4xl font-bold mb-6">{selectedItem.nome}</h1>
      <div className="bg-purple-900/50 rounded-2xl p-6 border border-pink-500/30 mb-6">
        <h3 className="text-white text-xl font-bold mb-4">Incluído:</h3>
        <div className="space-y-2">
          {selectedItem.itens.map((item, i) => <div key={i} className="flex items-center gap-2 text-gray-300"><Check className="text-green-400" size={20} /><span>{item}</span></div>)}
        </div>
      </div>
      <div className="bg-purple-900/50 rounded-2xl p-6 border border-pink-500/30 mb-6">
        <label className="text-white font-semibold mb-2 block">Convidados: {qtdConvidados}</label>
        <input type="range" min={selectedItem.convidadosMin} max={selectedItem.convidadosMax} value={qtdConvidados} onChange={(e) => setQtdConvidados(parseInt(e.target.value))} className="w-full" />
        <div className="mt-4 flex justify-between text-white font-bold text-xl">
          <span>Total:</span>
          <span className="text-pink-500">{formatCurrency(valorTotal)}</span>
        </div>
      </div>
      <button onClick={() => { addToCart({ ...selectedItem, tipo: 'pacote', qtdConvidados, valorTotal }); setCurrentScreen('carrinho'); }} className="w-full px-6 py-4 bg-gradient-to-r from-pink-500 to-yellow-500 text-white font-bold rounded-xl text-lg">
        Adicionar - {formatCurrency(valorTotal)}
      </button>
    </div>
  );
}

function DetalheServicoScreen() {
  const { selectedItem, setCurrentScreen, addToCart } = useApp();
  if (!selectedItem) { setCurrentScreen('catalogo'); return null; }
  
  return (
    <div className="max-w-4xl mx-auto px-4 py-6">
      <button onClick={() => setCurrentScreen('catalogo')} className="flex items-center gap-2 text-pink-400 mb-6"><ArrowLeft size={20} />Voltar</button>
      <img src={selectedItem.imagem} alt={selectedItem.titulo} className="w-full h-96 object-cover rounded-3xl mb-6" />
      <h1 className="text-white text-4xl font-bold mb-3">{selectedItem.titulo}</h1>
      <p className="text-gray-300 text-lg mb-6">{selectedItem.descricao}</p>
      <div className="bg-purple-900/50 rounded-2xl p-6 border border-pink-500/30 mb-6">
        <div className="flex justify-between items-center mb-4">
          <span className="text-gray-300 text-lg">Valor:</span>
          <span className="text-pink-500 text-4xl font-bold">{formatCurrency(selectedItem.valor)}</span>
        </div>
        <button onClick={() => { addToCart({ ...selectedItem, tipo: 'servico' }); setCurrentScreen('carrinho'); }} className="w-full px-6 py-4 bg-gradient-to-r from-pink-500 to-yellow-500 text-white font-bold rounded-xl text-lg">Adicionar ao Carrinho</button>
      </div>
    </div>
  );
}

function CarrinhoScreen() {
  const { cart, removeFromCart, setCurrentScreen, user, setPontos } = useApp();
  const total = cart.reduce((sum, item) => sum + (item.valorTotal || item.valor), 0);

  const handleCheckout = () => {
    if (!user) { alert('Faça login!'); setCurrentScreen('login'); return; }
    setPontos(prev => prev + Math.floor(total / 100));
    alert('🎉 Pedido realizado!');
    setCurrentScreen('home');
  };

  return (
    <div className="max-w-4xl mx-auto px-4 py-6">
      <h2 className="text-white text-3xl font-bold mb-6">Carrinho</h2>
      {cart.length === 0 ? (
        <div className="bg-purple-900/50 rounded-2xl p-12 border border-pink-500/30 text-center">
          <p className="text-gray-400 text-lg mb-6">Carrinho vazio</p>
          <button onClick={() => setCurrentScreen('catalogo')} className="px-6 py-3 bg-gradient-to-r from-pink-500 to-yellow-500 text-white font-bold rounded-xl">Explorar</button>
        </div>
      ) : (
        <div className="space-y-6">
          {cart.map(item => (
            <div key={item.cartId} className="bg-purple-900/50 rounded-2xl p-4 border border-pink-500/30 flex justify-between items-center">
              <div>
                <h3 className="text-white font-bold text-lg">{item.nome || item.titulo}</h3>
                <p className="text-pink-500 font-bold text-xl">{formatCurrency(item.valorTotal || item.valor)}</p>
              </div>
              <button onClick={() => removeFromCart(item.cartId)} className="text-red-400"><X size={24} /></button>
            </div>
          ))}
          <div className="bg-purple-900/50 rounded-2xl p-6 border border-pink-500/30">
            <div className="flex justify-between mb-6">
              <span className="text-white text-2xl font-bold">Total:</span>
              <span className="text-pink-500 text-3xl font-bold">{formatCurrency(total)}</span>
            </div>
            <button onClick={handleCheckout} className="w-full px-6 py-4 bg-gradient-to-r from-pink-500 to-yellow-500 text-white font-bold rounded-xl text-lg">Finalizar</button>
          </div>
        </div>
      )}
    </div>
  );
}

function ChatIAScreen() {
  const { chatMessages, setChatMessages } = useApp();
  const [input, setInput] = useState('');

  const enviar = () => {
    if (!input.trim()) return;
    const resposta = 'Entendi! Posso ajudar com sugestões de pacotes, orçamentos e ideias para sua festa!';
    setChatMessages([...chatMessages, { tipo: 'user', texto: input }, { tipo: 'bot', texto: resposta }]);
    setInput('');
  };

  return (
    <div className="max-w-4xl mx-auto px-4 py-6 h-[calc(100vh-180px)] flex flex-col">
      <h2 className="text-white text-3xl font-bold mb-6 flex items-center gap-2"><Bot size={32} className="text-pink-500" />Assistente IA</h2>
      <div className="flex-1 bg-purple-900/50 rounded-2xl border border-pink-500/30 p-4 overflow-y-auto mb-4 space-y-4">
        {chatMessages.length === 0 ? (
          <div className="text-center py-12">
            <Bot className="text-gray-400 mx-auto mb-4" size={64} />
            <p className="text-gray-400 text-lg">Como posso ajudar?</p>
          </div>
        ) : (
          chatMessages.map((msg, idx) => (
            <div key={idx} className={`flex ${msg.tipo === 'user' ? 'justify-end' : 'justify-start'}`}>
              <div className={`max-w-[80%] px-4 py-3 rounded-2xl ${msg.tipo === 'user' ? 'bg-pink-500 text-white' : 'bg-purple-950 text-gray-200'}`}>
                <p>{msg.texto}</p>
              </div>
            </div>
          ))
        )}
      </div>
      <div className="flex gap-2">
        <input type="text" value={input} onChange={(e) => setInput(e.target.value)} onKeyPress={(e) => e.key === 'Enter' && enviar()} placeholder="Digite sua pergunta..." className="flex-1 px-4 py-3 bg-purple-900/50 border border-pink-500/30 rounded-xl text-white placeholder-gray-400 focus:outline-none focus:border-pink-500" />
        <button onClick={enviar} className="px-6 py-3 bg-gradient-to-r from-pink-500 to-yellow-500 text-white font-bold rounded-xl"><Send size={20} /></button>
      </div>
    </div>
  );
}

function LoginScreen() {
  const { login } = useApp();
  const [isLogin, setIsLogin] = useState(true);
  const [tipoUsuario, setTipoUsuario] = useState('cliente');
  const [formData, setFormData] = useState({ 
    nome: '', 
    email: '', 
    senha: '', 
    telefone: '',
    cidade: '',
    cpf: '',
    cnpj: '',
    nomeEmpresa: '',
    categoria: '',
    descricao: ''
  });

  const handleSubmit = (e) => {
    e.preventDefault();
    if (isLogin) {
      login({ nome: formData.email.split('@')[0], email: formData.email, tipo: 'cliente' });
    } else {
      login({ 
        nome: formData.nome, 
        email: formData.email, 
        tipo: tipoUsuario,
        telefone: formData.telefone,
        cidade: formData.cidade
      });
    }
  };

  return (
    <div className="max-w-2xl mx-auto px-4 py-12">
      <div className="text-center mb-8">
        <PartyPopper className="text-yellow-400 mx-auto mb-4" size={64} />
        <h2 className="text-white text-3xl font-bold mb-2">
          {isLogin ? 'Bem-vindo de volta!' : 'Crie sua conta'}
        </h2>
        <p className="text-gray-400">
          {isLogin ? 'Entre para continuar' : 'Junte-se ao Festa Fácil'}
        </p>
      </div>

      {!isLogin && (
        <div className="flex gap-3 mb-6">
          <button
            type="button"
            onClick={() => setTipoUsuario('cliente')}
            className={`flex-1 px-6 py-4 rounded-xl font-bold transition-all ${
              tipoUsuario === 'cliente'
                ? 'bg-gradient-to-r from-pink-500 to-purple-500 text-white shadow-lg'
                : 'bg-purple-900/50 text-gray-300 border border-pink-500/30'
            }`}
          >
            <User className="mx-auto mb-2" size={32} />
            Cliente
            <p className="text-sm font-normal mt-1">Contrate serviços</p>
          </button>
          <button
            type="button"
            onClick={() => setTipoUsuario('fornecedor')}
            className={`flex-1 px-6 py-4 rounded-xl font-bold transition-all ${
              tipoUsuario === 'fornecedor'
                ? 'bg-gradient-to-r from-pink-500 to-purple-500 text-white shadow-lg'
                : 'bg-purple-900/50 text-gray-300 border border-pink-500/30'
            }`}
          >
            <Store className="mx-auto mb-2" size={32} />
            Fornecedor
            <p className="text-sm font-normal mt-1">Ofereça serviços</p>
          </button>
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-4 bg-purple-900/50 rounded-2xl p-6 border border-pink-500/30">
        {!isLogin && (
          <>
            <div>
              <label className="text-white font-semibold mb-2 block">Nome Completo *</label>
              <input
                type="text"
                required
                value={formData.nome}
                onChange={(e) => setFormData({...formData, nome: e.target.value})}
                className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white focus:outline-none focus:border-pink-500"
                placeholder="Seu nome completo"
              />
            </div>

            {tipoUsuario === 'fornecedor' && (
              <>
                <div>
                  <label className="text-white font-semibold mb-2 block">Nome da Empresa *</label>
                  <input
                    type="text"
                    required
                    value={formData.nomeEmpresa}
                    onChange={(e) => setFormData({...formData, nomeEmpresa: e.target.value})}
                    className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white focus:outline-none focus:border-pink-500"
                    placeholder="Nome fantasia da empresa"
                  />
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="text-white font-semibold mb-2 block">CPF *</label>
                    <input
                      type="text"
                      required
                      value={formData.cpf}
                      onChange={(e) => setFormData({...formData, cpf: e.target.value})}
                      className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white focus:outline-none focus:border-pink-500"
                      placeholder="000.000.000-00"
                      maxLength="14"
                    />
                  </div>
                  <div>
                    <label className="text-white font-semibold mb-2 block">CNPJ</label>
                    <input
                      type="text"
                      value={formData.cnpj}
                      onChange={(e) => setFormData({...formData, cnpj: e.target.value})}
                      className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white focus:outline-none focus:border-pink-500"
                      placeholder="00.000.000/0000-00"
                      maxLength="18"
                    />
                  </div>
                </div>

                <div>
                  <label className="text-white font-semibold mb-2 block">Categoria de Serviço *</label>
                  <select
                    required
                    value={formData.categoria}
                    onChange={(e) => setFormData({...formData, categoria: e.target.value})}
                    className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white focus:outline-none focus:border-pink-500"
                  >
                    <option value="">Selecione uma categoria</option>
                    <option value="Decoração">Decoração & Cenografia</option>
                    <option value="Gastronomia">Gastronomia</option>
                    <option value="Entretenimento">Entretenimento</option>
                    <option value="Registro">Registro & Mídia</option>
                    <option value="Espaço">Espaço & Estrutura</option>
                    <option value="Organização">Organização & Suporte</option>
                    <option value="Beleza">Beleza & Estética</option>
                    <option value="Tecnologia">Tecnologia & Audiovisual</option>
                    <option value="Shows">Shows & Apresentações</option>
                  </select>
                </div>

                <div>
                  <label className="text-white font-semibold mb-2 block">Descrição dos Serviços *</label>
                  <textarea
                    required
                    value={formData.descricao}
                    onChange={(e) => setFormData({...formData, descricao: e.target.value})}
                    className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white focus:outline-none focus:border-pink-500 h-24"
                    placeholder="Descreva os serviços que você oferece..."
                  />
                </div>
              </>
            )}
          </>
        )}

        <div>
          <label className="text-white font-semibold mb-2 block">E-mail *</label>
          <input
            type="email"
            required
            value={formData.email}
            onChange={(e) => setFormData({...formData, email: e.target.value})}
            className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white focus:outline-none focus:border-pink-500"
            placeholder="seu@email.com"
          />
        </div>

        {!isLogin && (
          <>
            <div>
              <label className="text-white font-semibold mb-2 block">Telefone/WhatsApp *</label>
              <input
                type="tel"
                required
                value={formData.telefone}
                onChange={(e) => setFormData({...formData, telefone: e.target.value})}
                className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white focus:outline-none focus:border-pink-500"
                placeholder="(00) 00000-0000"
                maxLength="15"
              />
            </div>

            <div>
              <label className="text-white font-semibold mb-2 block">Cidade *</label>
              <input
                type="text"
                required
                value={formData.cidade}
                onChange={(e) => setFormData({...formData, cidade: e.target.value})}
                className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white focus:outline-none focus:border-pink-500"
                placeholder="Sua cidade"
              />
            </div>
          </>
        )}

        <div>
          <label className="text-white font-semibold mb-2 block">Senha *</label>
          <input
            type="password"
            required
            value={formData.senha}
            onChange={(e) => setFormData({...formData, senha: e.target.value})}
            className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white focus:outline-none focus:border-pink-500"
            placeholder="••••••••"
            minLength="6"
          />
          {!isLogin && <p className="text-gray-400 text-sm mt-1">Mínimo 6 caracteres</p>}
        </div>

        {!isLogin && (
          <div className="flex items-start gap-3 p-4 bg-purple-950/50 rounded-xl">
            <input type="checkbox" required className="mt-1" id="termos" />
            <label htmlFor="termos" className="text-gray-300 text-sm">
              Eu aceito os <span className="text-pink-400 cursor-pointer hover:underline">Termos de Uso</span> e a <span className="text-pink-400 cursor-pointer hover:underline">Política de Privacidade</span> do Festa Fácil
            </label>
          </div>
        )}

        <button
          type="submit"
          className="w-full px-6 py-4 bg-gradient-to-r from-pink-500 to-yellow-500 text-white font-bold rounded-xl text-lg hover:shadow-xl transition-all"
        >
          {isLogin ? 'Entrar' : 'Criar Conta'}
        </button>
      </form>

      <div className="mt-6 text-center">
        <button
          onClick={() => setIsLogin(!isLogin)}
          className="text-pink-400 hover:text-pink-300 font-semibold"
        >
          {isLogin ? 'Não tem conta? Cadastre-se' : 'Já tem conta? Entre'}
        </button>
      </div>

      {!isLogin && tipoUsuario === 'fornecedor' && (
        <div className="mt-6 p-4 bg-yellow-500/10 border border-yellow-500/30 rounded-xl">
          <div className="flex items-start gap-3">
            <Sparkles className="text-yellow-400 mt-1" size={20} />
            <div>
              <h4 className="text-yellow-400 font-bold mb-1">Benefícios para Fornecedores</h4>
              <ul className="text-gray-300 text-sm space-y-1">
                <li>✓ Cadastre seus serviços gratuitamente</li>
                <li>✓ Receba pedidos direto no app</li>
                <li>✓ Gerencie sua agenda</li>
                <li>✓ Analytics e relatórios</li>
                <li>✓ Planos PRO disponíveis</li>
              </ul>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

function PerfilScreen() {
  const { user, setCurrentScreen } = useApp();
  if (!user) { setCurrentScreen('login'); return null; }
  
  return (
    <div className="max-w-4xl mx-auto px-4 py-6">
      <div className="bg-gradient-to-r from-pink-600 to-purple-600 rounded-3xl p-8 mb-6">
        <div className="flex items-center gap-4">
          <div className="w-20 h-20 bg-white rounded-full flex items-center justify-center text-purple-900 font-bold text-3xl">{user.nome[0]}</div>
          <div>
            <h2 className="text-white text-3xl font-bold">{user.nome}</h2>
            <p className="text-white/90">{user.email}</p>
          </div>
        </div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div className="bg-purple-900/50 rounded-2xl p-6 border border-pink-500/30">
          <Award className="text-yellow-400 mb-3" size={32} />
          <h3 className="text-white text-xl font-bold mb-2">Meus Pedidos</h3>
          <p className="text-gray-400">Acompanhe seus pedidos</p>
        </div>
        <div className="bg-purple-900/50 rounded-2xl p-6 border border-pink-500/30">
          <Heart className="text-pink-400 mb-3" size={32} />
          <h3 className="text-white text-xl font-bold mb-2">Favoritos</h3>
          <p className="text-gray-400">Seus favoritos</p>
        </div>
      </div>
    </div>
  );
}

function MontarFestaScreen() {
  const { pontos, addToCart, setCurrentScreen } = useApp();
  const isVIP = pontos >= 100;
  const [passo, setPasso] = useState(1);
  const [festa, setFesta] = useState({
    tipo: '',
    data: '',
    horario: '',
    duracao: 4,
    convidados: 50,
    cidade: '',
    endereco: '',
    cep: '',
    local: '',
    servicos: {
      espaco: null,
      decoracao: null,
      gastronomia: null,
      entretenimento: null,
      registro: null,
      extras: null,
      organização: null
    }
  });

  const SERVICOS_DISPONIVEIS = {
    espaco: [
      { id: 'e1', nome: 'Quintal Residencial', valor: 50000, descricao: 'Espaço simples, 50m²', local: 'Diversos bairros - São Paulo' },
      { id: 'e2', nome: 'Salão Comunitário', valor: 80000, descricao: 'Básico, 80m²', local: 'Zona Leste - São Paulo' },
      { id: 'e3', nome: 'Salão Simples', valor: 120000, descricao: 'Climatizado, 100m²', local: 'Zona Sul - São Paulo' },
      { id: 'e4', nome: 'Salão Premium 200m²', valor: 180000, descricao: 'Climatizado, estacionamento', local: 'Zona Sul - São Paulo' },
      { id: 'e5', nome: 'Casa de Festas Luxo', valor: 300000, descricao: 'Área externa, piscina', local: 'Jardins - São Paulo' }
    ],
    decoracao: [
      { id: 'd1', nome: 'Decoração Simples', valor: 80000, descricao: 'Balões básicos e toalha de mesa', fornecedor: 'Decorações Básicas' },
      { id: 'd2', nome: 'Decoração Econômica', valor: 120000, descricao: 'Balões temáticos e painel simples', fornecedor: 'Festa Fácil Decor' },
      { id: 'd3', nome: 'Decoração Completa', valor: 200000, descricao: 'Balões, painéis, mesa bolo', fornecedor: 'Arte & Festa' },
      { id: 'd4', nome: 'Decoração Temática Premium', valor: 350000, descricao: 'Tema completo com cenografia', fornecedor: 'Festa Mágica Decor' },
      { id: 'd5', nome: 'Decoração Luxo', valor: 580000, descricao: 'Cenografia completa premium', fornecedor: 'Luxo Eventos' }
    ],
    gastronomia: [
      { id: 'g1', nome: 'Salgados + Refrigerante', valor: 1500, descricao: 'Básico - por pessoa', fornecedor: 'Sabor Caseiro' },
      { id: 'g2', nome: 'Salgados + Doces + Bolo', valor: 2500, descricao: 'Econômico - por pessoa', fornecedor: 'Delícias da Vovó' },
      { id: 'g3', nome: 'Buffet Simples', valor: 4000, descricao: 'Salgados, doces, bolo - por pessoa', fornecedor: 'Buffet Família' },
      { id: 'g4', nome: 'Buffet Completo', valor: 8500, descricao: '10 opções - por pessoa', fornecedor: 'Sabor & Arte' },
      { id: 'g5', nome: 'Buffet Premium', valor: 15000, descricao: '20 opções gourmet - por pessoa', fornecedor: 'Buffet Premium' },
      { id: 'g6', nome: 'Buffet Luxo', valor: 25000, descricao: 'Menu completo, chef - por pessoa', fornecedor: 'Gourmet Master' }
    ],
    entretenimento: [
      { id: 'en1', nome: 'Som Ambiente (Caixa)', valor: 35000, descricao: 'Caixa de som + playlist', fornecedor: 'Som Básico' },
      { id: 'en2', nome: 'DJ Iniciante', valor: 60000, descricao: '3 horas', fornecedor: 'DJ Start' },
      { id: 'en3', nome: 'DJ + Som Básico', valor: 120000, descricao: '4 horas', fornecedor: 'Sound Events' },
      { id: 'en4', nome: 'DJ + Iluminação', valor: 180000, descricao: '5 horas', fornecedor: 'Sound Masters' },
      { id: 'en5', nome: 'Banda + DJ + Luz', valor: 350000, descricao: '6 horas', fornecedor: 'Premium Shows' },
      { id: 'en6', nome: 'Recreador', valor: 80000, descricao: '3 horas de brincadeiras', fornecedor: 'Alegria Kids' },
      { id: 'en7', nome: '2 Recreadores', valor: 150000, descricao: '4 horas', fornecedor: 'Diversão Total' },
      { id: 'en8', nome: 'Personagem (1)', valor: 90000, descricao: '2 horas', fornecedor: 'Personagens Mágicos' },
      { id: 'en9', nome: 'Palhaço', valor: 100000, descricao: '2 horas de show', fornecedor: 'Palhaço Risadinha' },
      { id: 'en10', nome: 'Mágico', valor: 120000, descricao: '1 hora de show', fornecedor: 'Mágico Fantástico' },
      { id: 'en11', nome: 'Pula-Pula', valor: 120000, descricao: '4 horas', fornecedor: 'Infláveis Alegria' },
      { id: 'en12', nome: 'Piscina de Bolinhas', valor: 80000, descricao: '4 horas', fornecedor: 'Diversão Kids' }
    ],
    registro: [
      { id: 'r1', nome: 'Fotógrafo Básico', valor: 80000, descricao: '3 horas, fotos digitais', fornecedor: 'Foto Express' },
      { id: 'r2', nome: 'Fotógrafo', valor: 180000, descricao: '4 horas, álbum digital', fornecedor: 'Clicks Momentos' },
      { id: 'r3', nome: 'Foto + Vídeo', valor: 320000, descricao: '5 horas, 2 profissionais', fornecedor: 'Registro Pro' },
      { id: 'r4', nome: 'Foto + Vídeo 4K + Drone', valor: 550000, descricao: 'Cobertura completa', fornecedor: 'Momentos Eternos' }
    ],
    extras: [
      { id: 'ex1', nome: 'Bolo Simples (2kg)', valor: 8000, descricao: 'Bolo tradicional', fornecedor: 'Doce Sabor' },
      { id: 'ex2', nome: 'Bolo Decorado (3kg)', valor: 15000, descricao: 'Bolo temático', fornecedor: 'Arte em Bolos' },
      { id: 'ex3', nome: 'Bolo Premium (4kg)', valor: 25000, descricao: 'Bolo cenográfico', fornecedor: 'Cake Design' },
      { id: 'ex4', nome: 'Lembrancinhas Simples', valor: 300, descricao: 'Por unidade', fornecedor: 'Lembranças Felizes' },
      { id: 'ex5', nome: 'Lembrancinhas Personalizadas', valor: 800, descricao: 'Por unidade', fornecedor: 'Personal Gifts' },
      { id: 'ex6', nome: 'Mesas e Cadeiras', valor: 35000, descricao: 'Conjunto básico até 50 pessoas', fornecedor: 'Locação Fácil' },
      { id: 'ex7', nome: 'Toalhas e Guardanapos', valor: 15000, descricao: 'Kit decorativo', fornecedor: 'Decoração Plus' },
      { id: 'ex8', nome: 'Descartáveis Completos', valor: 800, descricao: 'Por pessoa (pratos, copos, talheres)', fornecedor: 'Descartáveis Top' }
    ],
    organização: [
      { id: 'org1', nome: 'Coordenador', valor: 120000, descricao: 'Organização do evento', fornecedor: 'Eventos Perfeitos' },
      { id: 'org2', nome: 'Cerimonialista', valor: 200000, descricao: 'Cerimonial completo', fornecedor: 'Cerimonial Elegance' },
      { id: 'org3', nome: 'Garçom (1)', valor: 15000, descricao: '4 horas', fornecedor: 'Staff Eventos' },
      { id: 'org4', nome: 'Equipe de Garçons (3)', valor: 40000, descricao: '4 horas', fornecedor: 'Equipe Premium' },
      { id: 'org5', nome: 'Limpeza Pós-Evento', valor: 80000, descricao: 'Limpeza completa', fornecedor: 'Clean Fast' }
    ]
  };

  const calcularTotal = () => {
    let subtotal = 0;
    
    Object.entries(festa.servicos).forEach(([categoria, servico]) => {
      if (servico) {
        if (servico.id.startsWith('g') || servico.id.startsWith('ex')) {
          subtotal += servico.valor * festa.convidados;
        } else {
          subtotal += servico.valor;
        }
      }
    });

    const taxaServico = Math.floor(subtotal * 0.08);
    const descontoVIP = isVIP ? Math.floor(subtotal * 0.15) : 0;
    const total = subtotal - descontoVIP;

    return { subtotal, taxaServico, descontoVIP, total };
  };

  const valores = calcularTotal();

  const selecionarServico = (categoria, servico) => {
    setFesta({
      ...festa,
      servicos: { ...festa.servicos, [categoria]: servico }
    });
  };

  const finalizar = () => {
    addToCart({
      tipo: 'festa-personalizada',
      nome: `Festa ${festa.tipo} Personalizada`,
      ...festa,
      valorTotal: valores.total,
      cartId: Date.now()
    });
    alert('🎉 Festa adicionada ao carrinho!');
    setCurrentScreen('carrinho');
  };

  return (
    <div className="max-w-6xl mx-auto px-4 py-6">
      <div className="flex items-center justify-between mb-6">
        <button onClick={() => setCurrentScreen('home')} className="flex items-center gap-2 text-pink-400 font-semibold"><ArrowLeft size={20} />Voltar</button>
        <h2 className="text-white text-3xl font-bold flex items-center gap-2"><Sparkles className="text-yellow-400" />Monte sua Festa</h2>
        <div className="w-20"></div>
      </div>

      {!isVIP && (
        <div className="bg-gradient-to-r from-orange-500 to-pink-500 rounded-2xl p-4 mb-6 flex items-center gap-3 border-2 border-yellow-400">
          <Crown className="text-white" size={40} />
          <div className="flex-1">
            <p className="text-white font-bold">⚠️ Você não é assinante VIP!</p>
            <p className="text-white/90 text-sm">Assinantes VIP ganham 15% de desconto em tudo. Assine agora!</p>
          </div>
          <button className="px-4 py-2 bg-white text-orange-600 font-bold rounded-lg whitespace-nowrap">Assinar</button>
        </div>
      )}

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 space-y-6">
          {passo === 1 && (
            <div className="bg-purple-900/50 rounded-2xl p-6 border border-pink-500/30">
              <h3 className="text-white text-2xl font-bold mb-4">1. Informações Básicas</h3>
              <div className="space-y-4">
                <div>
                  <label className="text-white font-semibold mb-2 block">Tipo de Festa *</label>
                  <select value={festa.tipo} onChange={(e) => setFesta({...festa, tipo: e.target.value})} className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white">
                    <option value="">Selecione</option>
                    {TIPOS_FESTA.map(t => <option key={t} value={t}>{t}</option>)}
                  </select>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="text-white font-semibold mb-2 block">Data *</label>
                    <input type="date" value={festa.data} onChange={(e) => setFesta({...festa, data: e.target.value})} className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white" />
                  </div>
                  <div>
                    <label className="text-white font-semibold mb-2 block">Horário *</label>
                    <input type="time" value={festa.horario} onChange={(e) => setFesta({...festa, horario: e.target.value})} className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white" />
                  </div>
                </div>
                <div>
                  <label className="text-white font-semibold mb-2 block flex justify-between">
                    <span>Convidados: {festa.convidados}</span>
                  </label>
                  <input type="range" min="10" max="500" value={festa.convidados} onChange={(e) => setFesta({...festa, convidados: parseInt(e.target.value)})} className="w-full" />
                  <div className="flex justify-between text-gray-400 text-sm mt-1">
                    <span>10</span>
                    <span>500</span>
                  </div>
                </div>
                <div>
                  <label className="text-white font-semibold mb-2 block">Cidade *</label>
                  <input type="text" value={festa.cidade} onChange={(e) => setFesta({...festa, cidade: e.target.value})} placeholder="Sua cidade" className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white" />
                </div>
                <div>
                  <label className="text-white font-semibold mb-2 block">CEP</label>
                  <input type="text" value={festa.cep} onChange={(e) => setFesta({...festa, cep: e.target.value})} placeholder="00000-000" maxLength="9" className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white" />
                </div>
                <div>
                  <label className="text-white font-semibold mb-2 block">Endereço Completo</label>
                  <input type="text" value={festa.endereco} onChange={(e) => setFesta({...festa, endereco: e.target.value})} placeholder="Rua, número, bairro" className="w-full px-4 py-3 bg-purple-950 border border-pink-500/30 rounded-xl text-white" />
                </div>
                <button onClick={() => setPasso(2)} disabled={!festa.tipo || !festa.data} className="w-full px-6 py-3 bg-gradient-to-r from-pink-500 to-yellow-500 text-white font-bold rounded-xl disabled:opacity-50">Próximo: Escolher Serviços</button>
              </div>
            </div>
          )}

          {passo === 2 && (
            <div className="space-y-4">
              {Object.entries(SERVICOS_DISPONIVEIS).map(([categoria, opcoes]) => (
                <div key={categoria} className="bg-purple-900/50 rounded-2xl p-6 border border-pink-500/30">
                  <h3 className="text-white text-xl font-bold mb-4 capitalize flex items-center gap-2">
                    {categoria === 'espaco' && <Home size={24} className="text-pink-400" />}
                    {categoria === 'decoracao' && <Sparkles size={24} className="text-pink-400" />}
                    {categoria === 'gastronomia' && <Cake size={24} className="text-pink-400" />}
                    {categoria === 'entretenimento' && <Music size={24} className="text-pink-400" />}
                    {categoria === 'registro' && <Camera size={24} className="text-pink-400" />}
                    {categoria === 'extras' && <Gift size={24} className="text-pink-400" />}
                    {categoria === 'organização' && <Users size={24} className="text-pink-400" />}
                    {categoria}
                  </h3>
                  <div className="grid grid-cols-1 gap-3">
                    {opcoes.map(servico => {
                      const valorExibido = servico.id.startsWith('g') || servico.id.startsWith('ex') 
                        ? servico.valor * festa.convidados 
                        : servico.valor;
                      
                      return (
                        <div key={servico.id} onClick={() => selecionarServico(categoria, servico)} className={`p-4 rounded-xl border-2 cursor-pointer transition-all ${festa.servicos[categoria]?.id === servico.id ? 'border-pink-500 bg-pink-500/20' : 'border-pink-500/30 hover:border-pink-500/50'}`}>
                          <div className="flex justify-between items-start mb-2">
                            <div className="flex-1">
                              <h4 className="text-white font-bold">{servico.nome}</h4>
                              <p className="text-gray-400 text-sm">{servico.descricao}</p>
                              {servico.fornecedor && (
                                <div className="flex items-center gap-1 mt-1 text-purple-300 text-xs">
                                  <Store size={12} />
                                  <span>{servico.fornecedor}</span>
                                </div>
                              )}
                              {servico.local && (
                                <div className="flex items-center gap-1 mt-1 text-pink-400 text-sm">
                                  <MapPin size={14} />
                                  <span>{servico.local}</span>
                                </div>
                              )}
                            </div>
                            <div className="text-right ml-4">
                              <p className="text-pink-500 font-bold whitespace-nowrap">{formatCurrency(valorExibido)}</p>
                              {(servico.id.startsWith('g') || servico.id.startsWith('ex')) && <p className="text-gray-400 text-xs">por pessoa</p>}
                            </div>
                          </div>
                          {festa.servicos[categoria]?.id === servico.id && (
                            <div className="mt-2 flex items-center gap-2 text-green-400 text-sm"><Check size={16} />Selecionado</div>
                          )}
                        </div>
                      );
                    })}
                  </div>
                </div>
              ))}
              <div className="flex gap-3">
                <button onClick={() => setPasso(1)} className="flex-1 px-6 py-3 bg-purple-900/50 border border-pink-500/30 text-white font-bold rounded-xl">Voltar</button>
                <button onClick={() => setPasso(3)} className="flex-1 px-6 py-3 bg-gradient-to-r from-pink-500 to-yellow-500 text-white font-bold rounded-xl">Próximo: Pagamento</button>
              </div>
            </div>
          )}
        </div>

        <div className="lg:sticky lg:top-24 h-fit">
          <div className="bg-gradient-to-br from-purple-900 to-pink-900 rounded-2xl p-6 border-2 border-pink-500/50 shadow-2xl">
            <h3 className="text-white text-2xl font-bold mb-4 flex items-center gap-2">
              <DollarSign className="text-yellow-400" />
              Resumo
            </h3>
            
            <div className="space-y-3 mb-4">
              <div className="flex justify-between text-gray-300">
                <span>Subtotal:</span>
                <span className="font-bold">{formatCurrency(valores.subtotal)}</span>
              </div>
              
              {isVIP && (
                <div className="flex justify-between text-green-400">
                  <span className="flex items-center gap-1"><Crown size={16} />Desconto VIP (15%):</span>
                  <span className="font-bold">-{formatCurrency(valores.descontoVIP)}</span>
                </div>
              )}
              
              {!isVIP && valores.descontoVIP === 0 && valores.subtotal > 0 && (
                <div className="p-3 bg-orange-500/20 border border-orange-500/50 rounded-lg">
                  <p className="text-orange-300 text-sm font-semibold">💡 Economia perdida: {formatCurrency(Math.floor(valores.subtotal * 0.15))}</p>
                  <p className="text-orange-200 text-xs mt-1">Assinantes VIP economizam 15%!</p>
                </div>
              )}
            </div>

            <div className="border-t border-pink-500/30 pt-4 mb-6">
              <div className="flex justify-between items-center">
                <span className="text-white text-xl font-bold">Total:</span>
                <span className="text-pink-400 text-3xl font-bold">{formatCurrency(valores.total)}</span>
              </div>
            </div>

            <div className="bg-purple-950/50 rounded-xl p-4 mb-4">
              <div className="flex items-start gap-3">
                <CheckCircle className="text-green-400 mt-1" size={20} />
                <div>
                  <h4 className="text-white font-bold text-sm mb-1">✓ Garantia de Segurança</h4>
                  <p className="text-gray-400 text-xs">Pagamento 100% seguro e protegido</p>
                </div>
              </div>
            </div>

            <div className="bg-purple-950/50 rounded-xl p-4">
              <div className="flex items-start gap-3">
                <Award className="text-blue-400 mt-1" size={20} />
                <div>
                  <h4 className="text-white font-bold text-sm mb-1">✓ Fornecedores Verificados</h4>
                  <p className="text-gray-400 text-xs">Todos os profissionais são avaliados</p>
                </div>
              </div>
            </div>

            <div className="mt-4 text-center text-gray-400 text-xs">
              <p>🔒 Seus dados estão seguros</p>
              <p>📞 Suporte 24/7 disponível</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default FestaFacilApp;
