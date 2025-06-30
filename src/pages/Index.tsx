import React from 'react';
import { useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { 
  BookOpen, 
  Code, 
  Server, 
  Network, 
  Shield, 
  Cloud, 
  ArrowRight,
  Star,
  Users,
  Award
} from 'lucide-react';

const Index = () => {
  const navigate = useNavigate();

  const handleStartLearning = () => {
    navigate('/labs');
  };

  const features = [
    {
      icon: BookOpen,
      title: 'Beginner Friendly',
      description: 'Start from basics with step-by-step tutorials designed for Docker newcomers.'
    },
    {
      icon: Code,
      title: 'Hands-on Practice',
      description: 'Learn by doing with practical exercises and real-world scenarios.'
    },
    {
      icon: Server,
      title: 'Advanced Topics',
      description: 'Master complex concepts like orchestration, clustering, and enterprise deployment.'
    },
    {
      icon: Network,
      title: 'Networking Deep-dive',
      description: 'Understand Docker networking, from bridge networks to overlay networks.'
    },
    {
      icon: Shield,
      title: 'Security Best Practices',
      description: 'Learn how to secure your containers and implement security best practices.'
    },
    {
      icon: Cloud,
      title: 'Cloud Integration',
      description: 'Deploy and manage Docker containers across various cloud platforms.'
    }
  ];

  const stats = [
    { icon: BookOpen, value: '100+', label: 'Hands-on Labs' },
    { icon: Users, value: '50K+', label: 'Active Learners' },
    { icon: Award, value: '6', label: 'Skill Levels' },
    { icon: Star, value: '4.8', label: 'Average Rating' }
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-800">
      {/* Hero Section */}
      <div className="relative overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-r from-blue-600/20 to-purple-600/20"></div>
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24">
          <div className="text-center">
            <Badge variant="secondary" className="mb-4 px-4 py-2">
              🎉 New Modern Interface Available
            </Badge>
            <h1 className="text-5xl md:text-6xl font-bold text-gray-900 dark:text-white mb-6">
              Master <span className="text-blue-600 dark:text-blue-400">Docker</span> with
              <br />
              Interactive Labs
            </h1>
            <p className="text-xl text-gray-600 dark:text-gray-300 max-w-3xl mx-auto mb-8">
              Learn Docker through hands-on tutorials covering everything from basic containers 
              to advanced orchestration. Perfect for beginners to experts.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button size="lg" onClick={handleStartLearning} className="text-lg px-8 py-4">
                Start Learning
                <ArrowRight className="ml-2 w-5 h-5" />
              </Button>
              <Button size="lg" variant="outline" className="text-lg px-8 py-4">
                View All Labs
              </Button>
            </div>
          </div>
        </div>
      </div>

      {/* Stats Section */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
          {stats.map((stat, index) => (
            <Card key={index} className="text-center">
              <CardContent className="p-6">
                <stat.icon className="w-8 h-8 mx-auto mb-4 text-blue-600 dark:text-blue-400" />
                <div className="text-3xl font-bold text-gray-900 dark:text-white mb-2">
                  {stat.value}
                </div>
                <div className="text-sm text-gray-600 dark:text-gray-400">
                  {stat.label}
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>

      {/* Features Section */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">
            Why Choose Docker Labs?
          </h2>
          <p className="text-xl text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
            Our comprehensive learning platform is designed to take you from Docker novice to expert
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {features.map((feature, index) => (
            <Card key={index} className="hover:shadow-lg transition-shadow duration-200">
              <CardHeader>
                <feature.icon className="w-12 h-12 text-blue-600 dark:text-blue-400 mb-4" />
                <CardTitle>{feature.title}</CardTitle>
              </CardHeader>
              <CardContent>
                <CardDescription className="text-base">
                  {feature.description}
                </CardDescription>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>

      {/* Learning Path Section */}
      <div className="bg-white dark:bg-gray-800 py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">
              Your Learning Journey
            </h2>
            <p className="text-xl text-gray-600 dark:text-gray-300">
              Progress through carefully crafted modules designed for all skill levels
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <Card className="relative">
              <CardHeader>
                <div className="flex items-center gap-3">
                  <Badge variant="secondary" className="w-8 h-8 rounded-full flex items-center justify-center p-0">
                    1
                  </Badge>
                  <CardTitle>Beginner</CardTitle>
                </div>
              </CardHeader>
              <CardContent>
                <CardDescription className="mb-4">
                  Start with Docker basics, containers, and fundamental concepts
                </CardDescription>
                <ul className="space-y-2 text-sm">
                  <li>• Hello World Container</li>
                  <li>• Working with Images</li>
                  <li>• Container Management</li>
                  <li>• Basic Networking</li>
                </ul>
              </CardContent>
            </Card>

            <Card className="relative">
              <CardHeader>
                <div className="flex items-center gap-3">
                  <Badge variant="secondary" className="w-8 h-8 rounded-full flex items-center justify-center p-0">
                    2
                  </Badge>
                  <CardTitle>Intermediate</CardTitle>
                </div>
              </CardHeader>
              <CardContent>
                <CardDescription className="mb-4">
                  Dive deeper into Dockerfiles, volumes, and complex scenarios
                </CardDescription>
                <ul className="space-y-2 text-sm">
                  <li>• Multi-stage Builds</li>
                  <li>• Docker Compose</li>
                  <li>• Volume Management</li>
                  <li>• Advanced Networking</li>
                </ul>
              </CardContent>
            </Card>

            <Card className="relative">
              <CardHeader>
                <div className="flex items-center gap-3">
                  <Badge variant="secondary" className="w-8 h-8 rounded-full flex items-center justify-center p-0">
                    3
                  </Badge>
                  <CardTitle>Advanced</CardTitle>
                </div>
              </CardHeader>
              <CardContent>
                <CardDescription className="mb-4">
                  Master orchestration, security, and production deployments
                </CardDescription>
                <ul className="space-y-2 text-sm">
                  <li>• Docker Swarm</li>
                  <li>• Security Hardening</li>
                  <li>• CI/CD Integration</li>
                  <li>• Cloud Deployment</li>
                </ul>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>

      {/* CTA Section */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div className="bg-gradient-to-r from-blue-600 to-purple-600 rounded-2xl p-8 md:p-12 text-center text-white">
          <h2 className="text-3xl md:text-4xl font-bold mb-4">
            Ready to Start Your Docker Journey?
          </h2>
          <p className="text-xl mb-8 opacity-90">
            Join thousands of developers who have mastered Docker through our hands-on labs
          </p>
          <Button 
            size="lg" 
            variant="secondary" 
            onClick={handleStartLearning}
            className="text-lg px-8 py-4"
          >
            Explore All Labs
            <ArrowRight className="ml-2 w-5 h-5" />
          </Button>
        </div>
      </div>
    </div>
  );
};

export default Index;
