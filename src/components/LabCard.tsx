import React from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Clock, User, Tag } from 'lucide-react';
import { LabMetadata } from '@/types/lab';

interface LabCardProps {
  lab: LabMetadata;
  onClick: () => void;
}

const LabCard: React.FC<LabCardProps> = ({ lab, onClick }) => {
  const getDifficultyColor = (difficulty: number) => {
    switch (difficulty) {
      case 1: return 'bg-green-100 text-green-800 border-green-200';
      case 2: return 'bg-blue-100 text-blue-800 border-blue-200';
      case 3: return 'bg-yellow-100 text-yellow-800 border-yellow-200';
      case 4: return 'bg-orange-100 text-orange-800 border-orange-200';
      case 5: return 'bg-red-100 text-red-800 border-red-200';
      default: return 'bg-gray-100 text-gray-800 border-gray-200';
    }
  };

  const getDifficultyText = (difficulty: number) => {
    switch (difficulty) {
      case 1: return 'Beginner';
      case 2: return 'Easy';
      case 3: return 'Intermediate';
      case 4: return 'Advanced';
      case 5: return 'Expert';
      default: return 'Unknown';
    }
  };

  return (
    <Card 
      className="cursor-pointer transition-all duration-200 hover:shadow-lg hover:scale-105 border border-gray-200 dark:border-gray-700"
      onClick={onClick}
    >
      <CardHeader>
        <div className="flex items-start justify-between">
          <div className="flex-1">
            <CardTitle className="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-2">
              {lab.title}
            </CardTitle>
            <CardDescription className="text-gray-600 dark:text-gray-400 line-clamp-2">
              {lab.description}
            </CardDescription>
          </div>
          {lab.featured && (
            <Badge variant="secondary" className="ml-2 bg-yellow-100 text-yellow-800 border-yellow-200">
              Featured
            </Badge>
          )}
        </div>
      </CardHeader>
      <CardContent>
        <div className="space-y-3">
          {/* Difficulty and Duration */}
          <div className="flex items-center gap-4">
            <Badge className={getDifficultyColor(lab.difficulty)}>
              {getDifficultyText(lab.difficulty)}
            </Badge>
            <div className="flex items-center gap-1 text-sm text-gray-500 dark:text-gray-400">
              <Clock className="w-4 h-4" />
              <span>{lab.duration}</span>
            </div>
          </div>

          {/* Author */}
          {lab.author && (
            <div className="flex items-center gap-1 text-sm text-gray-500 dark:text-gray-400">
              <User className="w-4 h-4" />
              <span>{lab.author}</span>
            </div>
          )}

          {/* Tags */}
          <div className="flex items-center gap-1 flex-wrap">
            <Tag className="w-4 h-4 text-gray-400" />
            {lab.tags.slice(0, 3).map((tag, index) => (
              <Badge key={index} variant="outline" className="text-xs">
                {tag}
              </Badge>
            ))}
            {lab.tags.length > 3 && (
              <span className="text-xs text-gray-400">+{lab.tags.length - 3}</span>
            )}
          </div>

          {/* Prerequisites */}
          {lab.prerequisites && lab.prerequisites.length > 0 && (
            <div className="text-xs text-gray-500 dark:text-gray-400">
              <span className="font-medium">Prerequisites: </span>
              {lab.prerequisites.join(', ')}
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  );
};

export default LabCard;
