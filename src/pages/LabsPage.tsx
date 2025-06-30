import React, { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { 
  Search, 
  Filter, 
  BookOpen, 
  Code, 
  Shield, 
  Cloud,
  Network,
  Server,
  ChevronRight
} from 'lucide-react';
import LabCard from '@/components/LabCard';
import { LabMetadata, LabCategory } from '@/types/lab';

interface LabsPageProps {
  onLabSelect: (lab: LabMetadata) => void;
}

const LabsPage: React.FC<LabsPageProps> = ({ onLabSelect }) => {
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedCategory, setSelectedCategory] = useState<string>('all');

  // Sample lab data - will be replaced with actual lab content
  const categories: LabCategory[] = [
    {
      name: 'beginners',
      description: 'Start your Docker journey with these fundamental tutorials',
      icon: 'BookOpen',
      labs: [
        {
          id: 'hello-world',
          title: 'Hello World - Your First Docker Container',
          description: 'Learn the basics of Docker by running your first container with the classic hello-world image.',
          category: 'beginners',
          difficulty: 1,
          duration: '10 minutes',
          tags: ['basics', 'getting-started', 'containers'],
          lastUpdated: '2024-06-30',
          featured: true
        },
        {
          id: 'first-ubuntu-container',
          title: 'Running Your First Ubuntu Container',
          description: 'Learn how to run and interact with an Ubuntu container, exploring basic container operations.',
          category: 'beginners',
          difficulty: 1,
          duration: '15 minutes',
          tags: ['ubuntu', 'containers', 'interactive'],
          lastUpdated: '2024-06-30'
        },
        {
          id: 'dockerfile-intro',
          title: 'Introduction to Dockerfile',
          description: 'Create your first Dockerfile and understand how to build custom Docker images.',
          category: 'beginners',
          difficulty: 2,
          duration: '20 minutes',
          tags: ['dockerfile', 'build', 'images'],
          lastUpdated: '2024-06-30'
        },
        {
          id: 'bridge-networks',
          title: 'Docker Bridge Networks',
          description: 'Understanding Docker bridge networks and how containers communicate.',
          category: 'beginners',
          difficulty: 2,
          duration: '25 minutes',
          tags: ['networking', 'bridge', 'communication'],
          lastUpdated: '2024-06-30'
        }
      ]
    },
    {
      name: 'intermediate',
      description: 'Advance your Docker skills with more complex scenarios',
      icon: 'Code',
      labs: [
        {
          id: 'multi-stage-builds',
          title: 'Multi-stage Docker Builds',
          description: 'Learn how to create efficient Docker images using multi-stage builds.',
          category: 'intermediate',
          difficulty: 3,
          duration: '30 minutes',
          tags: ['dockerfile', 'optimization', 'multi-stage'],
          lastUpdated: '2024-06-30'
        }
      ]
    },
    {
      name: 'advanced',
      description: 'Master advanced Docker concepts and enterprise practices',
      icon: 'Server',
      labs: [
        {
          id: 'docker-swarm',
          title: 'Docker Swarm Orchestration',
          description: 'Learn container orchestration with Docker Swarm mode.',
          category: 'advanced',
          difficulty: 4,
          duration: '45 minutes',
          tags: ['swarm', 'orchestration', 'clustering'],
          lastUpdated: '2024-06-30'
        }
      ]
    },
    {
      name: 'networking',
      description: 'Deep dive into Docker networking concepts',
      icon: 'Network',
      labs: []
    },
    {
      name: 'security',
      description: 'Learn Docker security best practices',
      icon: 'Shield',
      labs: []
    },
    {
      name: 'cloud',
      description: 'Deploy Docker containers in cloud environments',
      icon: 'Cloud',
      labs: []
    }
  ];

  const allLabs = categories.flatMap(category => category.labs);

  const filteredLabs = allLabs.filter(lab => {
    const matchesSearch = lab.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         lab.description.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         lab.tags.some(tag => tag.toLowerCase().includes(searchTerm.toLowerCase()));
    
    const matchesCategory = selectedCategory === 'all' || lab.category === selectedCategory;
    
    return matchesSearch && matchesCategory;
  });

  const getIcon = (iconName: string) => {
    const icons = {
      BookOpen: BookOpen,
      Code: Code,
      Server: Server,
      Network: Network,
      Shield: Shield,
      Cloud: Cloud
    };
    const IconComponent = icons[iconName as keyof typeof icons] || BookOpen;
    return <IconComponent className="w-6 h-6" />;
  };

  const featuredLabs = allLabs.filter(lab => lab.featured);

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      {/* Header */}
      <div className="bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <div className="text-center">
            <h1 className="text-4xl font-bold text-gray-900 dark:text-white mb-4">
              Docker Labs
            </h1>
            <p className="text-xl text-gray-600 dark:text-gray-300 max-w-3xl mx-auto">
              Master Docker with hands-on tutorials covering beginner to advanced topics. 
              Learn containers, networking, security, and cloud deployment.
            </p>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Featured Labs */}
        {featuredLabs.length > 0 && (
          <div className="mb-12">
            <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-6">
              Featured Labs
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {featuredLabs.map((lab) => (
                <LabCard
                  key={lab.id}
                  lab={lab}
                  onClick={() => onLabSelect(lab)}
                />
              ))}
            </div>
          </div>
        )}

        {/* Search and Filter */}
        <div className="mb-8">
          <div className="flex flex-col sm:flex-row gap-4 mb-6">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-4 h-4" />
              <Input
                placeholder="Search labs..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="pl-10"
              />
            </div>
            <Button variant="outline" className="shrink-0">
              <Filter className="w-4 h-4 mr-2" />
              Filter
            </Button>
          </div>
        </div>

        {/* Categories and Labs */}
        <Tabs value={selectedCategory} onValueChange={setSelectedCategory}>
          <TabsList className="grid w-full grid-cols-3 lg:grid-cols-6 mb-8">
            <TabsTrigger value="all">All Labs</TabsTrigger>
            {categories.map((category) => (
              <TabsTrigger key={category.name} value={category.name}>
                {category.name.charAt(0).toUpperCase() + category.name.slice(1)}
              </TabsTrigger>
            ))}
          </TabsList>

          {/* All Labs Tab */}
          <TabsContent value="all">
            <div className="space-y-8">
              {categories.map((category) => (
                category.labs.length > 0 && (
                  <div key={category.name}>
                    <div className="flex items-center justify-between mb-4">
                      <div className="flex items-center gap-3">
                        {getIcon(category.icon)}
                        <div>
                          <h3 className="text-xl font-semibold text-gray-900 dark:text-white">
                            {category.name.charAt(0).toUpperCase() + category.name.slice(1)}
                          </h3>
                          <p className="text-gray-600 dark:text-gray-400">
                            {category.description}
                          </p>
                        </div>
                      </div>
                      <Button variant="outline" size="sm">
                        View All
                        <ChevronRight className="w-4 h-4 ml-1" />
                      </Button>
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                      {category.labs.slice(0, 6).map((lab) => (
                        <LabCard
                          key={lab.id}
                          lab={lab}
                          onClick={() => onLabSelect(lab)}
                        />
                      ))}
                    </div>
                  </div>
                )
              ))}
            </div>
          </TabsContent>

          {/* Individual Category Tabs */}
          {categories.map((category) => (
            <TabsContent key={category.name} value={category.name}>
              <div className="mb-6">
                <div className="flex items-center gap-3 mb-4">
                  {getIcon(category.icon)}
                  <div>
                    <h2 className="text-2xl font-bold text-gray-900 dark:text-white">
                      {category.name.charAt(0).toUpperCase() + category.name.slice(1)} Labs
                    </h2>
                    <p className="text-gray-600 dark:text-gray-400">
                      {category.description}
                    </p>
                  </div>
                </div>
              </div>
              
              {category.labs.length > 0 ? (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                  {filteredLabs
                    .filter(lab => lab.category === category.name)
                    .map((lab) => (
                      <LabCard
                        key={lab.id}
                        lab={lab}
                        onClick={() => onLabSelect(lab)}
                      />
                    ))}
                </div>
              ) : (
                <Card>
                  <CardHeader>
                    <CardTitle>Coming Soon</CardTitle>
                    <CardDescription>
                      {category.name.charAt(0).toUpperCase() + category.name.slice(1)} labs are being migrated to the new platform.
                    </CardDescription>
                  </CardHeader>
                  <CardContent>
                    <p className="text-gray-600 dark:text-gray-400">
                      Check back soon for hands-on tutorials in this category.
                    </p>
                  </CardContent>
                </Card>
              )}
            </TabsContent>
          ))}
        </Tabs>

        {/* Stats */}
        <div className="mt-12 grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card>
            <CardContent className="p-6 text-center">
              <div className="text-2xl font-bold text-blue-600 dark:text-blue-400 mb-2">
                {allLabs.length}+
              </div>
              <div className="text-sm text-gray-600 dark:text-gray-400">
                Total Labs
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-6 text-center">
              <div className="text-2xl font-bold text-green-600 dark:text-green-400 mb-2">
                {categories.length}
              </div>
              <div className="text-sm text-gray-600 dark:text-gray-400">
                Categories
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-6 text-center">
              <div className="text-2xl font-bold text-purple-600 dark:text-purple-400 mb-2">
                Beginner
              </div>
              <div className="text-sm text-gray-600 dark:text-gray-400">
                to Expert
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-6 text-center">
              <div className="text-2xl font-bold text-orange-600 dark:text-orange-400 mb-2">
                Free
              </div>
              <div className="text-sm text-gray-600 dark:text-gray-400">
                & Open Source
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
};

export default LabsPage;
